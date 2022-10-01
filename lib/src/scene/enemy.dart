import 'package:calamity/src/math/vector2.dart';

import '../inputs/input_state.dart';
import '../render/renderer.dart';
import '../resources/image_resource.dart';
import '../resources/resources.dart';
import 'game_arena.dart';

class Enemy {
  ImageResource? _enemyImage;
  static final Vector2 bounds = new Vector2(50.0, 50.0);
  GameArena arena;

  Vector2 pos;
  bool isAlive = true;

  Vector2 getTargetPos() => arena.player.pos;
  ImageResource getEnemyImage() => _enemyImage ??= Resources.GameResources.getResource('enemy');

  Enemy(this.pos, this.arena);

  void update(PlayerInputState input, num deltaTime) {
  }

  void render(Renderer r) {
    r.renderImage(pos, bounds, getEnemyImage());
  }
}