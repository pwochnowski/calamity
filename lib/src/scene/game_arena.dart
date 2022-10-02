import 'dart:math';

import 'package:calamity/src/math/collision_helper.dart';
import 'package:calamity/src/math/static.dart';
import 'package:calamity/src/render/sprite.dart';
import 'package:calamity/src/scene/boulder.dart';
import 'package:calamity/src/scene/chick_spawner.dart';
import 'package:calamity/src/scene/player.dart';
import 'package:calamity/src/scene/score.dart';

import '../constants.dart';
import '../inputs/input_state.dart';
import '../math/vector2.dart';
import '../render/renderer.dart';
import '../resources/resources.dart';
import 'bullet.dart';
import 'bullet_spawner.dart';
import 'enemy.dart';
import 'enemy_spawner.dart';

class GameArena {
  final num width;
  final num height;
  final Player player;
  int lastScore = 0;
  final ImageSprite background;

  final BulletSpawner bulletSpawner;
  final EnemySpawner enemySpawner;
  final ChickSpawner chickSpawner = new ChickSpawner();
  final ScoreWidget scoreWidget = new ScoreWidget();

  // TODO: Generalize this
  final List<Bullet> bullets = [];
  final List<Boulder> boulders = [];
  final List<Chick> lostChicks = [];
  final List<Enemy> enemies = [];

  GameArena(this.width, this.height)
      : player = new Player(Constants.PLAYER_SPAWN),
        bulletSpawner = new BulletSpawner(),
        enemySpawner = new EnemySpawner(Constants.NUM_ENEMIES),
        background = new ImageSprite(
          new Vector2(width / 2, height / 2),
          new Vector2(width, height),
          Resources.GameResources.getResource(Resources.BACKGROUND),
        ) {
    player.arena = this;
    bulletSpawner.arena = this;
    enemySpawner.arena = this;
    chickSpawner.arena = this;
    scoreWidget.arena = this;
    reset();
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
      Vector2? shiftVector = CollisionHelper.shiftVectorCircleCircle(
          player.pos, player.radius, boulder.pos, boulder.radius);
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

    chickSpawner.update(input, deltaTime);
    for (Chick chick in lostChicks) {
      chick.update(input, deltaTime);
    }

    scoreWidget.update(input, deltaTime);
  }

  void render(Renderer r) {
    background.render(r);
    player.render(r);
    bulletSpawner.render(r);
    for (Bullet bullet in bullets) {
      bullet.render(r);
    }
    for (Boulder boulder in boulders) {
      boulder.render(r);
    }

    chickSpawner.render(r);
    for (Chick chick in lostChicks) {
      chick.render(r);
    }

    for (Enemy enemy in enemies) {
      enemy.render(r);
    }
    scoreWidget.render(r);
  }

  // read by model
  bool playing = true;
  void killPlayer() {
    playing = false;
    reset();
    print("Game over");
  }

  void reset() {
    // HACK
    lastScore = scoreWidget.score;
    player.reset();
    bullets.clear();
    chickSpawner.reset();
    enemies.clear();
    lostChicks.clear();
    scoreWidget.reset();
    boulders.clear();
    Random r = StaticData.random;
    for (int i = 0; i < Constants.NUM_BOULDERS; i++) {
      num x = r.nextDouble() * width;
      num y = r.nextDouble() * height;
      boulders.add(new Boulder(new Vector2(x, y), Constants.BOULDER_RADIUS));
    }
  }
}
