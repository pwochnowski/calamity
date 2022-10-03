import 'dart:math';

import 'package:calamity/src/constants.dart';
import 'package:calamity/src/math/static.dart';
import 'package:calamity/src/math/vector2.dart';

import '../inputs/input_state.dart';
import '../math/aabb.dart';
import '../math/collision_helper.dart';
import '../math/color.dart';
import '../math/direction.dart';
import '../math/segment.dart';
import '../render/renderer.dart';
import '../resources/animation_frame.dart';
import '../resources/animation_manifests.dart';
import '../resources/image_resource.dart';
import '../resources/resources.dart';
import 'game_arena.dart';
import 'player.dart';

class Enemy {
  EnemyAnimationManifest animations =
      Resources.GameResources.enemyAnimationManifest;
  static final Vector2 renderBounds = new Vector2(125, 125);
  GameArena arena;

  Vector2 pos;
  Vector2? boredTarget;
  double boredTime = 0;

  /// remaining ms the enemy is stunned for
  num _stun = 0;

  /// remaining health from 1 to 0
  num health = 1.0;
  bool get isAlive => health > 0;

  void setStun(num stun) {
    this._stun = stun;
  }

  void takeDamage(num damage) {
    health -= damage;
  }

  /// slows down based on damage taken
  num speedPercentage() {
    num damageTaken = 1 - health.clamp(0, 1);
    return 1 - damageTaken * damageTaken;
  }

  void heal(num deltaTime) {
    health = min(1.0, health + deltaTime * Constants.ENEMY_HEAL_PER_MSEC);
  }

  Vector2 getTargetPos() => boredTarget ?? arena.player.pos;

  Enemy(this.pos, this.arena) {
    currentAnimation = new AnimationInstance(
        animations.moveLeft, pos, renderBounds, Constants.PLAYER_ANIM_TIMESTEP);
  }

  /// debug segment for rendering the enemy's intent to target the players
  LineSeg debugTargetPlayer = LineSeg.ZERO;
  LineSeg debugAvoidOtherEnemies = LineSeg.ZERO;

  void updateBoredom(num deltaTime) {
    if (boredTarget == null) {
      num roll = StaticData.random.nextDouble();
      num thres = pow(2.0, -(deltaTime / Constants.ENEMY_BORED_P50_TIME));
      if (roll > thres) {
        boredTime = 0;
        boredTarget = new Vector2(
          StaticData.random.nextDouble() * arena.width,
          StaticData.random.nextDouble() * arena.height,
        );
      }
    } else {
      boredTime += deltaTime;
      if (boredTime > Constants.ENEMY_MAX_BORED_TIME ||
          pos.distanceTo(boredTarget!) < Constants.ENEMY_SPEED) {
        boredTarget = null;
      }
    }
  }

  void update(PlayerInputState input, num deltaTime) {
    heal(deltaTime);
    updateBoredom(deltaTime);
    // handles how much the enemies want to move apart from each other
    Iterable<Enemy> otherEnemies = arena.enemies.where((Enemy e) => e != this);
    Vector2 avoidDirection = Vector2.ZERO;

    // at distance 100 or less, an enemy's intent to move away
    // from other enemies is maximized
    double distanceStandardUnit = 100.0;
    for (Enemy enemy in otherEnemies) {
      num distance = pos.distanceTo(enemy.pos);
      if (distance != 0) {
        Vector2 otherToThis = (pos - enemy.pos).normalized();
        avoidDirection +=
            otherToThis * min(1.0, distanceStandardUnit / distance); // o00
      }
    }
    if (avoidDirection.length2() > 1.0) {
      avoidDirection = avoidDirection.normalized();
    }

    Vector2 playerDirection = (getTargetPos() - pos).normalized();
    Vector2 finalDirection =
        (playerDirection + avoidDirection * 0.3).normalized();

    debugTargetPlayer =
        new LineSeg(pos, pos + (playerDirection * Constants.ENEMY_SPEED));

    debugAvoidOtherEnemies =
        new LineSeg(pos, pos + (avoidDirection * Constants.ENEMY_SPEED));

    num moveDistance = Constants.ENEMY_SPEED * deltaTime * Constants.MsToS;
    moveDistance *= speedPercentage();

    _stun -= deltaTime;
    if (_stun <= 0) {
      pos += finalDirection * moveDistance;
      _updateDirection(finalDirection);
      currentAnimation.updateElapsed(deltaTime);
    }
  }

  void _updateDirection(Vector2 dir) {
    oldDirection = currentDirection;
    currentDirection = directionFromVec(dir);
  }

  late AnimationInstance currentAnimation;
  Direction? oldDirection;
  Direction? currentDirection;

  void render(Renderer r) {
    // r.renderLine(debugTargetPlayer, Color.RED);
    // r.renderLine(debugAvoidOtherEnemies, Color.BLUE);

    if (currentDirection != oldDirection) {
      currentAnimation = animations.newAnimationFromDirection(
          currentDirection, pos, renderBounds, Constants.PLAYER_ANIM_TIMESTEP);
    }
    currentAnimation.pos = pos;
    r.renderAnimation(currentAnimation);
  }

  bool collidesWithPlayer() {
    Player p = arena.player;
    return CollisionHelper.collidesCircleAABB(
        pos, Constants.ENEMY_RADIUS, AABB.fromLocAndSize(p.pos, p.size));
  }
}
