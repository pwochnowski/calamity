
import 'package:calamity/src/math/vector2.dart';

/// Actually a bunch of defaults used for initialising values
class Constants {
  // Prevent class from being constructed
  Constants._();

  static final int NUM_BULLETS = 5;
  static final int NUM_ENEMIES = 2;

  static final num BULLET_RADIUS = 5.0;
  static final num BULLET_SPEED = 4.0;
  static final num ENEMY_RADIUS = 25.0;
  static final num ENEMY_SPEED = 2.0;

  static final num PLAYER_RADIUS = 25.0;
  static final num PLAYER_MOVE_SPEED = 3.5;
  static final num PLAYER_BOOST_CD = 3 * 1000;
  static final num PLAYER_BOOST = 50;
  static final Vector2 PLAYER_SPAWN = new Vector2(100, 400);

  static final int NUM_CHICKS = 3;
  static final int CHICK_MOVE_SPEED = 1;
  static final int CHICK_RADIUS = 10;
  static final int CHICK_SPAWN_SECONDS = 10;
  static final int CHICK_SCORE = 3000;

  static final int NUM_BOULDERS = 3;
  static final num BOULDER_RADIUS = 20;
}