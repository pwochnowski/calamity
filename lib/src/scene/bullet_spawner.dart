import 'dart:math';

import 'package:calamity/src/constants.dart';
import 'package:calamity/src/inputs/input_state.dart';
import 'package:calamity/src/math/static.dart';
import 'package:calamity/src/resources/animation_frame.dart';
import 'package:calamity/src/scene/game_arena.dart';
import 'package:calamity/src/scene/shotgun.dart';
import 'package:calamity/src/scene/system.dart';

import '../globals.dart';
import '../math/vector2.dart';
import '../render/renderer.dart';
import '../resources/resources.dart';
import 'bullet.dart';

class BulletSpawner extends System {
  late final GameArena arena;
  static final Vector2 bulletHitbox = new Vector2(50, 50);
  num _elapsed = 0;

  BulletSpawner();

  @override
  void reset() {
    _elapsed = 0;
  }

  Shotgun spawnShotgunAtEdge() {
    // Pick an arena edge to use
    int edge = StaticData.random.nextInt(4);
    // Pick a random point on it
    double posOnEdge = StaticData.random.nextDouble();
    num x, y;
    Animation animation;
    switch (edge) {
      case 0: // LEFT EDGE
        x = 0;
        y = arena.height * posOnEdge;
        animation = Resources.GameResources.shotgunAnimationManifest.fromLeft;
        break;
      case 1: // TOP EDGE
        x = arena.width * posOnEdge;
        y = 0;
        animation = Resources.GameResources.shotgunAnimationManifest.fromTop;
        break;
      case 2: // RIGHT EDGE
        x = arena.width;
        y = arena.height * posOnEdge;
        animation = Resources.GameResources.shotgunAnimationManifest.fromRight;
        break;
      default: // TOP EDGE
        x = arena.width * posOnEdge;
        y = arena.height;
        animation = Resources.GameResources.shotgunAnimationManifest.fromBottom;
        break;
    }
    Vector2 position = new Vector2(x, y);
    num localAngle = 0.8 * (StaticData.random.nextDouble() - 0.5) * pi;
    num angle = (0.5 * edge) * pi + localAngle;
    return _createNewShotgun(position, angle, animation, localAngle);
  }

  Shotgun _createNewShotgun(
      Vector2 position, num angle, Animation animation, num shotgunRotation) {
    return new Shotgun(position + new Vector2(20, 0).rotated(angle), angle,
        arena, animation, shotgunRotation);
  }

  static Bullet createNewBullet(Vector2 position, num angle, GameArena arena,
      {bool isFromPlayer: false}) {
    Vector2 vel = new Vector2(cos(angle), sin(angle));
    if (isFromPlayer) {
      vel *= Constants.PLAYER_BULLET_SPEED_BASE;
    } else {
      vel *= Constants.BULLET_SPEED;
    }
    return new Bullet(position, angle, vel, arena, isFromPlayer: isFromPlayer);
  }

  void firePlayerBullet(Vector2 position, Vector2 mousePosition) {
    num dx = mousePosition.x - position.x;
    num dy = mousePosition.y - position.y;
    num angle = atan2(dy, dx);
    Bullet bullet = createNewBullet(position, angle, arena, isFromPlayer: true);
    arena.bullets.add(bullet);
  }

  num remainingCd = 0;

  @override
  void update(PlayerInputState input, num deltaTime) async {
    _elapsed += deltaTime;
    if (!arena.playing) {
      return;
    }

    arena.bullets.retainWhere((Bullet bullet) => bullet.isInBounds());
    int nonPlayerBulletsCount =
        arena.bullets.where((b) => !b.isFromPlayer).length +
            arena.shotguns.length;
    if (nonPlayerBulletsCount <
        Constants.NUM_BULLETS +
            (_elapsed / Constants.BULLET_COUNT_INCREASE_TIME).floor()) {
      if (remainingCd > 0) {
        remainingCd -= deltaTime;
      } else {
        arena.shotguns.add(spawnShotgunAtEdge());
        remainingCd = 500 / (1 + (_elapsed / 1000));
      }
    }
  }

  @override
  void render(Renderer r) {}
}
