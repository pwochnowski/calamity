import 'package:calamity/src/math/static.dart';
import 'package:calamity/src/resources/animation_frame.dart';
import 'package:calamity/src/resources/animation_manifests.dart';
import 'package:calamity/src/resources/animation_resource.dart';
import 'package:calamity/src/resources/image_resource.dart';
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
  int ammo = 0;

  LineSeg? path;
  Player(this.pos) {
    reset();
  }

  num _firingStun = 0;
  Direction? _firingStunDirection;

  void reset() {
    ammo = 3;
    currentAnimation = new AnimationInstance(
        animations.idle, pos, size, Constants.PLAYER_ANIM_TIMESTEP);
    pos = Constants.PLAYER_SPAWN;
    path = null;
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
    AABB bounds = getBounds();
    if (arena.feeders.any((element) => element.getBounds().intersects(bounds))) {
      if (feedCooldown < 0) {
        feedCooldown = Constants.PLAYER_FEED_CD;
        ammo += 1;
      }
    }
    feedCooldown -= deltaTime;
  }

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
    Vector2 delta = new Vector2(x, y).normalized() * speed * deltaTime * 0.001;
    _updateDirection(delta);
    pos += delta;
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
    oldDirection = currentDirection;
    currentDirection = directionFromVec(dir);
  }

  @override
  void update(PlayerInputState input, num deltaTime) {
    if (input.mouse.right) {
      path = new LineSeg(pos, input.mouse.pos!);
      print("Set path ${path!.length()}");
    }
    fireCooldown -= deltaTime;
    _firingStun -= deltaTime;
    if (input.mouse.left && fireCooldown < 0) {
      if (ammo > 0) {
        fireCooldown = Constants.PLAYER_FIRE_CD;
        ammo -= 1;
        arena.bulletSpawner.firePlayerBullet(pos, input.mouse.pos!);
        Vector2 knockbackDir = (pos - input.mouse.pos!).normalized();
        pos += knockbackDir * Constants.PLAYER_FIRE_KNOCKBACK;
        _firingStun = Constants.PLAYER_FIRE_STUN;
        _firingStunDirection = directionFromVec(-knockbackDir);
      }
    }
    move(input, deltaTime);
    addAmmoIfOnFeeder(deltaTime);
    currentAnimation.updateElapsed(
        boostCooldown > Constants.PLAYER_BOOST_CD ? 2 * deltaTime : deltaTime);
    limit();
  }

  @override
  void render(Renderer r) {
    if (_firingStun > 0 && _firingStunDirection != null) {
      // render the chicken after firing the bird seed
      // HACK render one frame of the animation
      AnimationInstance animation = animations.newAnimationFromDirection(
          _firingStunDirection, pos, size, Constants.PLAYER_ANIM_TIMESTEP);
      r.renderAnimation(animation);
    } else {
      if (currentDirection != oldDirection) {
        currentAnimation = animations.newAnimationFromDirection(
            currentDirection, pos, size, Constants.PLAYER_ANIM_TIMESTEP);
      }
      currentAnimation.pos = pos;
      r.renderAnimation(currentAnimation);
    }
  }

  AABB getBounds() {
    return AABB.fromLocAndSize(pos, size);
  }
}
