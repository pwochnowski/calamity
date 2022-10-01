import 'package:calamity/src/inputs/input_state.dart';
import 'package:calamity/src/render/renderer.dart';
import 'package:calamity/src/scene/game_arena.dart';
import 'package:calamity/src/scene/player.dart';

import '../math/vector2.dart';

class Bullet {
  Vector2 pos;
  Vector2 velocity;
  // AABB hitboxes
  double radius;
  GameArena _enclosingArena;

  Bullet(this.pos, this.velocity, this.radius, this._enclosingArena);

  void update(PlayerInputState) {
    pos += velocity;
  }

  void render(Renderer r) {
    // FIXME: Currently just a circle
    r.renderCircle(pos);
  }

  void setArena(GameArena arena) => this._enclosingArena = arena;

  bool isInBounds() => pos.x >= 0 && pos.y >= 0
    && pos.x <= _enclosingArena.width && pos.y <= _enclosingArena.height;

  bool collidesWithPlayer() {
    Player p = _enclosingArena.player;
    num dist = p.pos.distanceTo(pos);
    print("Dist ${dist}");
    return dist <  p.radius + radius;
  }

}