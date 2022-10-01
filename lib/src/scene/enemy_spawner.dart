import 'dart:math';

import '../constants.dart';
import '../inputs/input_state.dart';
import '../math/static.dart';
import '../math/vector2.dart';
import '../render/renderer.dart';
import 'enemy.dart';
import 'game_arena.dart';

class EnemySpawner {
  late final GameArena arena;
  int numEnemies;


  EnemySpawner(this.numEnemies);

  // TODO: Factor this out? Same code as BulletSpawner
  Enemy spawnEnemyAtEdge() {
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
      x = 0;
      y = arena.height * posOnEdge;
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
    Enemy bullet = new Enemy(position, arena);
    return bullet;
  }

  void update(PlayerInputState input, num deltaTime) {
    if (!arena.playing) {
      return;
    }
    arena.enemies.retainWhere((Enemy enemy) => enemy.isAlive);
    int numToSpawn = max(0, numEnemies - arena.enemies.length);
    for (int i = 0; i < numToSpawn; ++i) {
      arena.enemies.add(spawnEnemyAtEdge());
    }
  }

  void render(Renderer r) {}

}