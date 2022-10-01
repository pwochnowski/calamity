import 'dart:math';

import 'package:calamity/src/constants.dart';
import 'package:calamity/src/inputs/input_state.dart';
import 'package:calamity/src/math/static.dart';
import 'package:calamity/src/scene/game_arena.dart';

import '../math/vector2.dart';
import '../render/renderer.dart';
import 'bullet.dart';

class BulletSpawner {
  late final GameArena _enclosingArena;
  int numBullets = 10;
  static final Vector2 bulletHitbox = new Vector2(50, 50);

  void setArena(GameArena arena) => _enclosingArena = arena;

  BulletSpawner(this.numBullets);

  Bullet spawnBulletAtEdge() {
    // Pick an arena edge to use
    int edge = StaticData.random.nextInt(4);
    // Pick a random point on it
    double posOnEdge = StaticData.random.nextDouble();
    num x, y;
    switch (edge) {
    case 0: // LEFT EDGE
      x = 0;
      y = _enclosingArena.height * posOnEdge;
      break;
    case 1: // TOP EDGE
      x = 0;
      y = _enclosingArena.height * posOnEdge;
      break;
    case 2: // RIGHT EDGE
      x = _enclosingArena.width;
      y = _enclosingArena.height * posOnEdge;
      break;
    default: // TOP EDGE
      x = _enclosingArena.width * posOnEdge;
      y = _enclosingArena.height;
      break;
    }
    Vector2 position = new Vector2(x, y);
    num angle = (0.5 * edge + 0.8 * (StaticData.random.nextDouble() - 0.5)) * pi;
    Vector2 vel = new Vector2(cos(angle), sin(angle)) * Constants.BULLET_SPEED;
    Bullet bullet = new Bullet(position, vel, _enclosingArena);
    return bullet;
  }

  void update(PlayerInputState input) {
    GameArena arena = _enclosingArena;
    if (!arena.playing) {
      return;
    }
    arena.bullets.retainWhere((Bullet bullet) => bullet.isInBounds());
    int numToSpawn = max(0, numBullets - arena.bullets.length);
    for (int i = 0; i < numToSpawn; ++i) {
      arena.bullets.add(spawnBulletAtEdge());
    }
  }

  void render(Renderer r) {}
}