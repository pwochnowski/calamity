import 'dart:math';

import 'package:calamity/src/math/collision_helper.dart';
import 'package:calamity/src/math/static.dart';
import 'package:calamity/src/scene/boulder.dart';
import 'package:calamity/src/scene/player.dart';

import '../constants.dart';
import '../inputs/input_state.dart';
import '../math/vector2.dart';
import '../render/renderer.dart';
import 'bullet.dart';
import 'bullet_spawner.dart';
import 'enemy.dart';
import 'enemy_spawner.dart';

class GameArena {
  final num width;
  final num height;
  final Player player;

  final BulletSpawner bulletSpawner;
  final EnemySpawner enemySpawner;
  // TODO: Generalize this
  final List<Bullet> bullets = [];
  final List<Boulder> boulders = [];
  final List<Enemy> enemies = [];

  GameArena(this.width, this.height)
      : player = new Player(new Vector2(100, 200)),
        bulletSpawner = new BulletSpawner(),
        enemySpawner = new EnemySpawner(Constants.NUM_ENEMIES) {

    Random r = StaticData.random;
    for (int i = 0; i < 10; i++) {
      num x = r.nextDouble() * width;
      num y = r.nextDouble() * height;
      boulders.add(new Boulder(new Vector2(x, y)));
    }
    player.arena = this;
    bulletSpawner.arena = this;
    enemySpawner.arena = this;
  }

  void update(PlayerInputState input, num deltaTime) {
    player.update(input, deltaTime);
    bulletSpawner.update(input, deltaTime);
    enemySpawner.update(input, deltaTime);

    for (Bullet bullet in bullets) {
      bullet.update(input, deltaTime);

      if (bullet.collidesWithPlayer()) {
        killPlayer();
        break;
      }
    }
    for (Boulder boulder in boulders) {
      Vector2? shiftVector = CollisionHelper.shiftVectorCircleCircle(player.pos, player.radius, boulder.pos, boulder.radius);
      if (shiftVector != null) {
        player.pos += shiftVector;
      }
    }
    for (Enemy enemy in enemies) {
      enemy.update(input, deltaTime);

      if (enemy.collidesWithPlayer()) {
        killPlayer();
        break;
      }
    }
  }

  void render(Renderer r) {
    player.render(r);
    bulletSpawner.render(r);
    for (Bullet bullet in bullets) {
      bullet.render(r);
    }
    for (Boulder boulder in boulders) {
      boulder.render(r);
    }
    for (Enemy enemy in enemies) {
      enemy.render(r);
    }
  }

  // read by model
  bool playing = true;

  void killPlayer() {
    playing = false;
    bullets.clear();
    enemies.clear();
    print("Game over");
  }
}
