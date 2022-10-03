import 'package:calamity/src/resources/animation_frame.dart';
import 'package:calamity/src/resources/animation_manifests.dart';

import '../constants.dart';
import '../inputs/input_state.dart';
import '../math/aabb.dart';
import '../math/collision_helper.dart';
import '../math/direction.dart';
import '../math/segment.dart';
import '../math/vector2.dart';
import '../render/renderer.dart';
import '../resources/resources.dart';
import 'game_arena.dart';
import 'game_object.dart';
import 'player.dart';

class Chick extends GameObject {
  final GameArena arena;
  final ChickAnimationManifest animations =
      Resources.GameResources.chickAnimationManifest;
  late AnimationInstance currentAnimation;
  Direction? lastDirection;
  Direction? currentDirection;

  late Vector2 _pos;

  num speed = Constants.CHICK_MOVE_SPEED;
  num radius = Constants.CHICK_RADIUS;
  final Vector2 size =
      new Vector2(2 * Constants.CHICK_RADIUS, 2 * Constants.CHICK_RADIUS);

  LineSeg? path;

  Chick(this.arena, this.path) : _pos = path!.start {
    currentAnimation =
        animations.newAnimationFromDirection(null, pos, size, 400);
  }

  @override
  // TODO: implement pos
  Vector2 get pos => this._pos;
  void setPos(Vector2 newPos) => this._pos = newPos;

  bool checkPlayerCollision() {
    Player p = arena.player;

    bool collides = CollisionHelper.collidesCircleAABB(
        pos, radius, AABB.fromLocAndSize(p.pos, p.size));

    if (collides && arena.lostChicks.contains(this)) {
      arena.lostChicks.remove(this);
      arena.scoreWidget.addSavedChick();
      arena.addChickScore(pos);
    }

    return collides;
  }

  @override
  void render(Renderer r) {
    r.renderAnimation(currentAnimation);
  }

  @override
  void update(PlayerInputState input, num deltaTime) {
    lastDirection = currentDirection;
    currentDirection = directionFromVec(path?.dir() ?? Vector2.ZERO);
    if (lastDirection != currentDirection) {
      num lastElapsed = currentAnimation.elapsed;
      double timeStep = currentDirection == null ? 400 : 100;
      currentAnimation = animations.newAnimationFromDirection(
          currentDirection, pos, size, timeStep);
      // Synchronise animation to other chicks in wave
      currentAnimation.updateElapsed(lastElapsed + deltaTime);
    } else {
      currentAnimation.updateElapsed(deltaTime);
    }
    bool collides = checkPlayerCollision();
    if (collides) {
      return;
    }

    if (path != null) {
      Vector2 newPos = path!.dir() * speed * deltaTime * 0.001;
      num ratio = path!.ratioOnSeg(pos);
      if (ratio < 1.0) {
        _pos += newPos;
      } else {
        _pos = path!.end;
        path = null;
      }
      currentAnimation.pos = _pos;
      return;
    }
  }
}
