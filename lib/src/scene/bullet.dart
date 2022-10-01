import 'package:calamity/src/inputs/input_state.dart';
import 'package:calamity/src/render/renderer.dart';
import 'package:calamity/src/scene/game_arena.dart';

import '../math/vector2.dart';

class Bullet {
  Vector2 pos;
  Vector2 velocity;
  // AABB hitboxes
  Vector2 hitBox;
  GameArena? _enclosingArena;

  Bullet(this.pos, this.velocity, this.hitBox);

  void update(PlayerInputState) {
    pos += velocity;
  }

  void render(Renderer r) {
    // FIXME: Currently just a circle
    r.renderCircle(pos);
  }

  void setArena(GameArena arena) => this._enclosingArena = arena;

  bool isInBounds() => pos.x >= 0 && pos.y >= 0 && pos.x <= _enclosingArena!.width && pos.y <= _enclosingArena!.height;
}