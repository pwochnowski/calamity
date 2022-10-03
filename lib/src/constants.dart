import 'package:calamity/src/math/vector2.dart';

/// Actually a bunch of defaults used for initialising values
/// Speeds are in pixels/second
class Constants {
  // Prevent class from being constructed
  Constants._();

  static final int NUM_BULLETS = 5;
  static final int NUM_ENEMIES = 2;
  static final int NUM_FEEDERS = 2;

  static final int CANVAS_WIDTH = 948;
  static final int CANVAS_HEIGHT = 533;

  static final num BULLET_RADIUS = 10.0;
  static final num PLAYER_BULLET_RADIUS = 5.0;
  static final num BULLET_SPEED = 240.0;
  static final num PLAYER_BULLET_SPEED_BASE = 600.0;
  static final num BULLET_COUNT_INCREASE_TIME = 30 * SToMs;
  static final num ENEMY_COUNT_INCREASE_TIME = 40 * SToMs;
  static final num ENEMY_RADIUS = 25.0;
  static final num ENEMY_SPEED = 120.0;
  static final num ENEMY_MAX_BORED_TIME = 8 * SToMs;
  static final num ENEMY_BORED_P50_TIME = 15 * SToMs;

  // how much to push an enemy back if they are hit by bullet
  static final num BULLET_KNOCKBACK = 50.0;

  // duration the bullet causes stun
  static final num BULLET_STUN = 300.0;

  /// milliseconds to seconds
  static final num MsToS = 0.001;

  /// seconds to milliseconds
  static final num SToMs = 1000;

  static final num PLAYER_RADIUS = 25.0;
  static final num PLAYER_MOVE_SPEED = 210;
  static final num PLAYER_BOOST_CD = 3 * 1000;
  static final num PLAYER_BOOST_FACTOR = 2;
  static final num PLAYER_FEED_CD = 200;
  static final num PLAYER_FIRE_CD = 500;
  static final num PLAYER_FIRE_KNOCKBACK = 20;
  static final num PLAYER_FIRE_STUN = 100;
  static final num PLAYER_DURATION = 500;
  static final num PLAYER_ANIM_TIMESTEP = 100;
  static final Vector2 PLAYER_SPAWN =
      new Vector2(CANVAS_WIDTH ~/ 2, CANVAS_HEIGHT ~/ 2);

  static final int NUM_CHICKS = 3;
  static final int CHICK_MOVE_SPEED = 60;
  static final int CHICK_RADIUS = 10;
  static final int CHICK_SPAWN_SECONDS = 10;
  static final int CHICK_SCORE = 3000;

  static final int NUM_BOULDERS = 3;
  static final num BOULDER_RADIUS = 20;
}
