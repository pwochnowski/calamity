import 'dart:math';

import 'package:calamity/src/constants.dart';
import 'package:calamity/src/math/vector2.dart';

import '../inputs/input_state.dart';
import '../math/aabb.dart';
import '../math/collision_helper.dart';
import '../render/renderer.dart';
import '../resources/image_resource.dart';
import '../resources/resources.dart';
import 'game_arena.dart';
import 'player.dart';

class Enemy {
  ImageResource? _enemyImage;
  static final Vector2 bounds = new Vector2(2 * Constants.ENEMY_RADIUS, 2 * Constants.ENEMY_RADIUS);
  GameArena arena;

  Vector2 pos;
  bool isAlive = true;

  Vector2 getTargetPos() => arena.player.pos;
  ImageResource getEnemyImage() => _enemyImage ??= Resources.GameResources.getResource('enemy');

  Enemy(this.pos, this.arena);

  void update(PlayerInputState input, num deltaTime) {
    Vector2 movementVec = getTargetPos() - pos;
    num distToMove = min(Constants.ENEMY_SPEED * deltaTime * 0.001, movementVec.length());
    Vector2 movementDir = movementVec.normalized();
    pos += movementDir * distToMove;
  }

  void render(Renderer r) {
    r.renderImage(pos, bounds, getEnemyImage());
  }

  bool collidesWithPlayer() {
    Player p = arena.player;
    return CollisionHelper.collidesCircleAABB(pos, Constants.ENEMY_RADIUS, AABB.fromLocAndSize(p.pos, p.size));
  }
}