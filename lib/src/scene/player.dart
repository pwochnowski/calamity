import 'package:calamity/src/math/static.dart';
import 'package:calamity/src/resources/animation_frame.dart';
import 'package:calamity/src/resources/animation_manifests.dart';
import 'package:calamity/src/resources/animation_resource.dart';
import 'package:calamity/src/resources/image_resource.dart';
import 'package:calamity/src/scene/feeder.dart';
import 'package:calamity/src/scene/game_arena.dart';
import 'package:calamity/src/scene/game_object.dart';

import '../constants.dart';
import '../inputs/input_state.dart';
import '../math/aabb.dart';
import '../math/direction.dart';
import '../math/segment.dart';
import '../math/vector2.dart';
import '../render/renderer.dart';
import '../resources/resources.dart';

class Player extends GameObject {
  late GameArena arena;
  PlayerAnimationManifest animations =
      Resources.GameResources.playerAnimationManifest;
  late AnimationInstance currentAnimation;

  // used for hitbox of player
  final num radius = Constants.PLAYER_RADIUS;

  num movementSpeed = Constants.PLAYER_MOVE_SPEED;
  Vector2 pos;
  Vector2 size = new Vector2(50, 50);
  Direction? oldDirection;
  Direction? currentDirection;
  int ammo = 1;

  LineSeg? path;
  Player(this.pos) {
    reset();
  }

  num _firingStun = 0;

  void reset() {
    ammo = 1;
    currentAnimation = new AnimationInstance(
        animations.idle, pos, size, Constants.PLAYER_ANIM_TIMESTEP);
    pos = Constants.PLAYER_SPAWN;
    path = null;
    _firingStun = 0;
    resetCooldowns();
  }

  num boostCooldown = 0;
  num feedCooldown = 0;
  num fireCooldown = 0;

  void resetCooldowns() {
    boostCooldown = 0;
    feedCooldown = 0;
    fireCooldown = 0;
  }

  void addAmmoIfOnFeeder(num deltaTime) {
    feedCooldown -= deltaTime;
    AABB bounds = getBounds();
    Iterable<Feeder> intersectingFeeders = arena.feeders
        .where((element) => element.getBounds().intersects(bounds));
    if (feedCooldown < 0 && intersectingFeeders.isNotEmpty) {
      bool anyHasSeed = false;
      for (Feeder f in intersectingFeeders) {
        anyHasSeed |= f.tryTakeSeed();
      }
      if (anyHasSeed) {
        feedCooldown = Constants.PLAYER_FEED_CD;
        ammo += 1;
      }
    }
  }

  Vector2 _lastMovementDir = new Vector2(1.0, 0.0);

  void move(PlayerInputState input, num deltaTime) {
    num speed = movementSpeed;
    if (input.keys.contains(PlayerKey.DASH)) {
      if (boostCooldown < 0) {
        boostCooldown = Constants.PLAYER_BOOST_CD + Constants.PLAYER_DURATION;
        arena.standaloneAnimations
            .add(new AnimationInstance(animations.featherFall, pos, size, 150));
      }
    }
    if (boostCooldown > Constants.PLAYER_BOOST_CD) {
      speed *= Constants.PLAYER_BOOST_FACTOR;
    }
    boostCooldown -= deltaTime;

    if (path != null) {
      Vector2 newPos = path!.dir() * speed * deltaTime * 0.001;
      _updateDirection(newPos);
      _lastMovementDir = newPos.normalized();
      num ratio = path!.ratioOnSeg(pos);
      if (ratio < 1.0) {
        pos += newPos;
      } else {
        pos = path!.end;
        path = null;
      }
      return;
    }

    double x = 0.0;
    double y = 0.0;

    if (input.keys.contains(PlayerKey.LEFT)) {
      x -= 1;
    }
    if (input.keys.contains(PlayerKey.RIGHT)) {
      x += 1;
    }
    if (input.keys.contains(PlayerKey.UP)) {
      y -= 1;
    }
    if (input.keys.contains(PlayerKey.DOWN)) {
      y += 1;
    }
    Vector2 delta = new Vector2(x, y).normalized();
    _updateDirection(delta);
    if (delta.length2() > 0) {
      _lastMovementDir = delta;
      delta *= speed * deltaTime * 0.001;
      pos += delta;
    }
  }

  /// limit the player so they don't move outside the bounds
  void limit() {
    if (pos.x < size.x / 2) {
      pos = pos.setX(size.x / 2);
    }
    if (pos.y < size.y / 2) {
      pos = pos.setY(size.y / 2);
    }
    if (pos.x + size.x / 2 > arena.width) {
      pos = pos.setX(arena.width - size.x / 2);
    }
    if (pos.y + size.y / 2 > arena.height) {
      pos = pos.setY(arena.height - size.y / 2);
    }
  }

  void _updateDirection(Vector2 dir) {
    // HACK
    if (_firingStun < 0) {
      oldDirection = currentDirection;
      currentDirection = directionFromVec(dir);
    }
  }

  @override
  void update(PlayerInputState input, num deltaTime) {
    if (input.mouse.right) {
      path = new LineSeg(pos, input.mouse.pos!);
      // print("Set path ${path!.length()}");
    }
    fireCooldown -= deltaTime;
    _firingStun -= deltaTime;
    move(input, deltaTime);
    if (ammo > 0 && fireCooldown < 0) {
      Vector2? targetPos;
      if (input.mouse.left) {
        targetPos = input.mouse.pos;
      } else if (input.keys.contains(PlayerKey.SHOOT)) {
        targetPos = pos + _lastMovementDir;
      }
      if (targetPos != null) {
        fireCooldown = Constants.PLAYER_FIRE_CD;
        ammo -= 1;
        arena.bulletSpawner.firePlayerBullet(pos, targetPos);
        Vector2 knockbackDir = (pos - targetPos).normalized();
        pos += knockbackDir * Constants.PLAYER_FIRE_KNOCKBACK;
        _updateDirection(-knockbackDir);
        _firingStun = Constants.PLAYER_FIRE_STUN;
      }
    }
    addAmmoIfOnFeeder(deltaTime);
    currentAnimation.updateElapsed(
        boostCooldown > Constants.PLAYER_BOOST_CD ? 2 * deltaTime : deltaTime);
    limit();
  }

  @override
  void render(Renderer r) {
    if (currentDirection != oldDirection) {
      currentAnimation = animations.newAnimationFromDirection(
          currentDirection, pos, size, Constants.PLAYER_ANIM_TIMESTEP);
    }
    currentAnimation.pos = pos;
    r.renderAnimation(currentAnimation);
  }

  AABB getBounds() {
    return AABB.fromLocAndSize(pos, size);
  }
}
