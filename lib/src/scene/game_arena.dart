import 'dart:math';

import 'package:calamity/src/math/collision_helper.dart';
import 'package:calamity/src/math/static.dart';
import 'package:calamity/src/render/sprite.dart';
import 'package:calamity/src/resources/animation_frame.dart';
import 'package:calamity/src/scene/ammo.dart';
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
import 'chick.dart';
import 'enemy.dart';
import 'enemy_spawner.dart';
import 'feeder.dart';

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
  final AmmoWidget ammoWidget = new AmmoWidget();

  // TODO: Generalize this
  final List<Bullet> bullets = [];
  final List<Boulder> boulders = [];
  final List<Chick> lostChicks = [];
  final List<Enemy> enemies = [];
  final List<Feeder> feeders = [];
  final List<AnimationInstance> standaloneAnimations = [];

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
    ammoWidget.arena = this;
    reset();
  }

  void update(PlayerInputState input, num deltaTime) {
    player.update(input, deltaTime);
    bulletSpawner.update(input, deltaTime);
    enemySpawner.update(input, deltaTime);

    Set<Bullet> bulletsToRemove = new Set();
    for (Bullet bullet in bullets) {
      bullet.update(input, deltaTime);

      if (!bullet.isFromPlayer && bullet.collidesWithPlayer()) {
        killPlayer();
        break;
      }

      if (bullet.isFromPlayer) {
        for (Enemy e in enemies) {
          Vector2? enemyShiftVector = bullet.collideWithEnemy(e);
          if (enemyShiftVector != null) {
            e.pos += enemyShiftVector;
            e.setStun(Constants.BULLET_STUN);
            bulletsToRemove.add(bullet);
            break;
          }
        }
      }
    }

    bullets.removeWhere(bulletsToRemove.contains);
    for (Enemy enemy in enemies) {
      enemy.update(input, deltaTime);

      if (enemy.collidesWithPlayer()) {
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
      for (Enemy enemy in enemies) {
        Vector2? shiftVector = CollisionHelper.shiftVectorCircleCircle(
            enemy.pos, Constants.ENEMY_RADIUS, boulder.pos, boulder.radius);
        if (shiftVector != null) {
          enemy.pos += shiftVector;
        }
      }
    }

    chickSpawner.update(input, deltaTime);
    for (Chick chick in lostChicks) {
      chick.update(input, deltaTime);
    }

    scoreWidget.update(input, deltaTime);
    for (AnimationInstance animation in standaloneAnimations) {
      animation.updateElapsed(deltaTime);
    }
    standaloneAnimations.removeWhere((animation) => animation.hasEnded());
  }

  void render(Renderer r) {
    background.render(r);
    for (Feeder feeder in feeders) {
      feeder.render(r);
    }

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
    for (AnimationInstance animation in standaloneAnimations) {
      r.renderAnimation(animation);
    }
    scoreWidget.render(r);
    ammoWidget.render(r);
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
    bulletSpawner.reset();
    enemies.clear();
    lostChicks.clear();
    scoreWidget.reset();
    boulders.clear();
    standaloneAnimations.clear();
    feeders.clear();
    Random r = StaticData.random;
    for (int i = 0; i < Constants.NUM_BOULDERS; i++) {
      num x = r.nextDouble() * width;
      num y = r.nextDouble() * height;
      boulders.add(new Boulder(new Vector2(x, y), Constants.BOULDER_RADIUS));
    }
    feeders.add(new Feeder(new Vector2(250, height - 50), new Vector2(300, 50)));
  }
}
