
import 'package:calamity/src/inputs/input_state.dart';
import 'package:calamity/src/math/vector2.dart';
import 'package:calamity/src/render/renderer.dart';
import 'package:calamity/src/scene/game_arena.dart';
import 'package:calamity/src/scene/game_object.dart';
import 'package:calamity/src/scene/player.dart';

import '../constants.dart';
import '../math/aabb.dart';
import '../math/collision_helper.dart';
import '../math/segment.dart';
import '../math/static.dart';

class ChickSpawner {
  late GameArena arena;
  num cooldown = Constants.CHICK_SPAWN_SECONDS * 1000; // millis

  void update(PlayerInputState input, num deltaTime) {

    if (cooldown > 0) {
      cooldown -= deltaTime;
    } else {
      spawnChicks();
      cooldown = Constants.CHICK_SPAWN_SECONDS * 1000;
    }
  }

  void spawnChicks() {
    for (int i = 0; i < Constants.NUM_CHICKS; i++) {
      Chick chick = Chick(arena);

      chick.path = new LineSeg(
        new Vector2(400, 0),
        new Vector2.random(800, 400),
      );

      chick._pos = chick.path!.start;


      arena.lostChicks.add(chick);
    }
  }

  void render(Renderer r) {
    r.ctx.strokeText(cooldown.ceil().toString(), 400, 10);
  }
}

class Chick extends GameObject {
  final GameArena arena;

  late Vector2 _pos;

  num speed = Constants.CHICK_MOVE_SPEED;
  num radius = Constants.CHICK_RADIUS;

  LineSeg? path;

  Chick(this.arena);

  @override
  // TODO: implement pos
  Vector2 get pos => this._pos;


  bool checkPlayerCollision() {
    Player p = arena.player;

    bool collides = CollisionHelper.collidesCircleAABB(pos, radius,
      AABB.fromLocAndSize(p.pos, p.size)
    );
    print("Collides $collides");

    if (collides) {
      arena.lostChicks.remove(this);
      arena.scoreWidget.add(Constants.CHICK_SCORE);
    }

    return collides;
  }

  @override
  void render(Renderer r) {
    r.ctx.setStrokeColorRgb(200, 200, 140);
    r.renderSemiCircle(_pos);
    r.ctx.setStrokeColorRgb(0, 0, 0);
  }

  @override
  void update(PlayerInputState input, num deltaTime) {
    bool collides = checkPlayerCollision();
    if (collides) {
      return;
    }

    if (path != null) {
      Vector2 newPos = path!.dir() * speed;
      num ratio = path!.ratioOnSeg(pos);
      if (ratio < 1.0) {
        _pos += newPos;
      } else {
        _pos = path!.end;
        path = null;
      }
      return;
    }
  }

}