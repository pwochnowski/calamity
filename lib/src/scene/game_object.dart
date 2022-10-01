import '../inputs/input_state.dart';
import '../math/vector2.dart';
import '../render/renderer.dart';

/// game object with basic position and rotation information
abstract class GameObject {

  /// having a public getter for position allows other entities to update
  /// their behaviour based on any object in the game
  ///
  /// e.g. an enemy that can shoot at a player but also the player's allies
  Vector2 get pos;

  /// the game object should have basic knowledge of how to update itself
  ///
  /// this should not necessarly perform non-trivial AI decisions, e.g. an
  /// enemy decide which player/entity to target can be done in a separate AI
  /// system which calls setTarget on the enemy first
  void update(PlayerInputState input, num deltaTime);

  /// the game object should have knowledge of how to render itself to the screen
  void render(Renderer r);
}
