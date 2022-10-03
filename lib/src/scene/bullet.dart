import 'dart:math';

import 'package:calamity/src/inputs/input_state.dart';
import 'package:calamity/src/math/collision_helper.dart';
import 'package:calamity/src/render/renderer.dart';
import 'package:calamity/src/resources/animation_frame.dart';
import 'package:calamity/src/scene/enemy.dart';
import 'package:calamity/src/scene/game_arena.dart';
import 'package:calamity/src/scene/game_object.dart';
import 'package:calamity/src/scene/player.dart';

import '../constants.dart';
import '../math/aabb.dart';
import '../math/vector2.dart';
import '../resources/resources.dart';

class Bullet extends GameObject {
  Vector2 pos;
  Vector2 velocity;
  num angle;
  // AABB hitboxes
  final num radius = Constants.BULLET_RADIUS;
  GameArena _enclosingArena;
  late AnimationInstance currentAnimation;

  final bool isFromPlayer;

  Bullet(this.pos, this.angle, this.velocity, this._enclosingArena,
      {this.isFromPlayer: false}) {
    currentAnimation = new AnimationInstance(
      Resources.GameResources.bulletAnimationManifest.travelling,
      pos,
      new Vector2(2 * radius, 2 * radius),
      50,
    );
    currentAnimation.rotation = angle - pi * 0.5;
  }

  @override
  void update(PlayerInputState, num deltaTime) {
    pos += velocity * (deltaTime * 0.001);
    currentAnimation.updateElapsed(deltaTime);
    currentAnimation.pos = pos;
  }

  @override
  void render(Renderer r) {
    r.renderAnimation(currentAnimation);
  }

  void setArena(GameArena arena) => this._enclosingArena = arena;

  bool isInBounds() =>
      pos.x >= 0 &&
      pos.y >= 0 &&
      pos.x <= _enclosingArena.width &&
      pos.y <= _enclosingArena.height;

  bool collidesWithPlayer() {
    Player p = _enclosingArena.player;
    return CollisionHelper.collidesCircleAABB(
        pos, radius, AABB.fromLocAndSize(p.pos, p.size));
  }

  /// returns the pushback vector if the bullet collides with the enemy
  Vector2? collideWithEnemy(Enemy e) {
    bool collides = CollisionHelper.collidesCircleCircle(e.pos, Constants.ENEMY_RADIUS, pos, radius);
    if (!collides) {
      return null;
    }
    return velocity.normalized() * Constants.BULLET_KNOCKBACK;
  }
}
