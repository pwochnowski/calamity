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
  num _elapsed = 0;

  BulletSpawner();

  void reset() {
    _elapsed = 0;
  }

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
    return _createNewBullet(position, angle, isFromPlayer: false);
  }

  Bullet _createNewBullet(Vector2 position, num angle, {bool isFromPlayer: false}) {
    Vector2 vel = new Vector2(cos(angle), sin(angle));
    if (isFromPlayer) {
      vel *= Constants.PLAYER_BULLET_SPEED_BASE;
    } else {
      vel *= Constants.BULLET_SPEED;
    }
    return new Bullet(position, angle, vel, arena, isFromPlayer: isFromPlayer);
  }

  void firePlayerBullet(Vector2 position, Vector2 mousePosition) {
    num dx = mousePosition.x - position.x;
    num dy = mousePosition.y - position.y;
    num angle = atan2(dy, dx);
    Bullet bullet = _createNewBullet(position, angle, isFromPlayer: true);
    arena.bullets.add(bullet);
  }

  num remainingCd = 0;

  void update(PlayerInputState input, num deltaTime) async {
    _elapsed += deltaTime;
    if (!arena.playing) {
      return;
    }

    arena.bullets.retainWhere((Bullet bullet) => bullet.isInBounds());

    if (arena.bullets.length <
        Constants.NUM_BULLETS +
            (_elapsed / Constants.BULLET_COUNT_INCREASE_TIME).floor()) {
      if (remainingCd > 0) {
        remainingCd -= deltaTime;
      } else {
        arena.bullets.add(spawnBulletAtEdge());
        remainingCd = 500 / (1 + (_elapsed / 1000));
      }
    }
  }

  void render(Renderer r) {}
}
