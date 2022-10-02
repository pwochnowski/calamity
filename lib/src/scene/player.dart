
import 'package:calamity/src/math/static.dart';
import 'package:calamity/src/resources/animation_resource.dart';
import 'package:calamity/src/resources/image_resource.dart';
import 'package:calamity/src/scene/game_arena.dart';
import 'package:calamity/src/scene/game_object.dart';

import '../constants.dart';
import '../inputs/input_state.dart';
import '../math/segment.dart';
import '../math/vector2.dart';
import '../render/renderer.dart';
import '../resources/resources.dart';

class Player extends GameObject {
  AnimationResource? _playerAnimation;
  late GameArena arena;

  // used for hitbox of player
  final num radius = Constants.PLAYER_RADIUS;

  num movementSpeed = Constants.PLAYER_MOVE_SPEED;
  Vector2 pos;
  Vector2 size = new Vector2(50, 50);

  LineSeg? path;
  Player(this.pos);

  void reset() {
    pos = Constants.PLAYER_SPAWN;
    path = null;
    resetCooldowns();
  }

  num boostCooldown = 0;
  void resetCooldowns() {
    boostCooldown = 0;
  }

  void move(PlayerInputState input, num deltaTime) {
    num speed = movementSpeed;
    if (input.keys.contains(PlayerKey.DASH)) {
      if (boostCooldown < 0) {
        speed += Constants.PLAYER_BOOST;
        boostCooldown = Constants.PLAYER_BOOST_CD;
        print("Boost ${speed}");
      }
    }
    boostCooldown -= deltaTime;

    if (path != null) {
      // FIXME: This overshoots
      Vector2 newPos = path!.dir() * speed;
      num ratio = path!.ratioOnSeg(pos);
      if (ratio < 1.0) {
        pos += newPos;
      } else {
        pos = path!.end;
        path = null;
      }
      return;
    }

    double x = 0.0;
    double y = 0.0;

    if (input.keys.contains(PlayerKey.LEFT)) { x -= 1; }
    if (input.keys.contains(PlayerKey.RIGHT)) { x += 1; }
    if (input.keys.contains(PlayerKey.UP)) { y -= 1; }
    if (input.keys.contains(PlayerKey.DOWN)) { y += 1; }
    pos += new Vector2(x, y).normalized() * speed;

  }

  /// limit the player so they don't move outside the bounds
  void limit() {
    if (pos.x < size.x / 2) {
      pos = pos.setX(size.x / 2);
    }
    if (pos.y < size.y / 2) {
      pos = pos.setY(size.y / 2);
    }
    if (pos.x + size.x / 2 > arena.width) {
      pos = pos.setX(arena.width - size.x / 2);
    }
    if (pos.y + size.y / 2 > arena.height) {
      pos = pos.setY(arena.height - size.y / 2);
    }
  }


  @override
  void update(PlayerInputState input, num deltaTime) {
    if (input.mouse.right ) {
      path = new LineSeg(pos, input.mouse.pos!);
      print("Set path ${path!.length()}");
    }
    move(input, deltaTime);
    limit();
  }


  int frame = 0;
  @override
  void render(Renderer r) {
    AnimationResource animation = getPlayerAnimation();
    if (StaticData.random.nextDouble() < 0.1) {
      frame = StaticData.random.nextInt(animation.frameCount);
    }
    r.renderAnimationFrame(pos, size, animation, frame);
  }

  AnimationResource getPlayerAnimation() => _playerAnimation ??= Resources.GameResources.getResource(Resources.PLAYER_ANIMATION);
}

