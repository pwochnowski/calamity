import '../inputs/input_state.dart';
import '../render/renderer.dart';

abstract class System {
  /// resets the system, but not the entities created by the system
  void reset();

  /// performs a frame update for the system
  void update(PlayerInputState input, num deltaTime);

  /// renders the GUI or other visual indication of the system
  /// but not the entities created by the system
  void render(Renderer r) {}
}
