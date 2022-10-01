import '../math/vector2.dart';

/// game object with basic position and rotation information
///
/// having a public getter for position allows other entities to update
/// their behaviour based on any object in the game
///
/// e.g. an enemy that can shoot at a player but also the player's allies
abstract class GameObject {
  Vector2 get pos;
}
