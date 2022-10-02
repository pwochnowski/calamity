import 'dart:math';

import 'package:calamity/src/constants.dart';
import 'package:calamity/src/inputs/input_state.dart';
import 'package:calamity/src/math/static.dart';
import 'package:calamity/src/scene/game_arena.dart';

import '../globals.dart';
import '../math/vector2.dart';
import '../render/renderer.dart';
import 'bullet.dart';

class BulletSpawner {
  late final GameArena arena;
  static final Vector2 bulletHitbox = new Vector2(50, 50);

  BulletSpawner();

  Bullet spawnBulletAtEdge() {
    // Pick an arena edge to use
    int edge = StaticData.random.nextInt(4);
    // Pick a random point on it
    double posOnEdge = StaticData.random.nextDouble();
    num x, y;
    switch (edge) {
      case 0: // LEFT EDGE
        x = 0;
        y = arena.height * posOnEdge;
        break;
      case 1: // TOP EDGE
        x = arena.width * posOnEdge;
        y = 0;
        break;
      case 2: // RIGHT EDGE
        x = arena.width;
        y = arena.height * posOnEdge;
        break;
      default: // TOP EDGE
        x = arena.width * posOnEdge;
        y = arena.height;
        break;
    }
    Vector2 position = new Vector2(x, y);
    num angle =
        (0.5 * edge + 0.8 * (StaticData.random.nextDouble() - 0.5)) * pi;
    Vector2 vel = new Vector2(cos(angle), sin(angle)) * Constants.BULLET_SPEED;
    Bullet bullet = new Bullet(position, angle, vel, arena);
    return bullet;
  }

  num remainingCd = 0;

  void update(PlayerInputState input, num deltaTime) async {
    if (!arena.playing) {
      return;
    }

    arena.bullets.retainWhere((Bullet bullet) => bullet.isInBounds());

    if (arena.bullets.length < Constants.NUM_BULLETS) {
      if (remainingCd > 0) {
        remainingCd -= deltaTime;
      } else {
        arena.bullets.add(spawnBulletAtEdge());
        remainingCd = 500;
      }
    }
  }

  void render(Renderer r) {}
}
