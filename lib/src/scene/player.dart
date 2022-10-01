
import '../inputs/input_state.dart';
import '../math/vector2.dart';
import '../render/renderer.dart';

class Player {
  Vector2 pos;

  Player(this.pos);

  void handleInput(InputState inputs) {
    pos += inputs.getDirectionFromArrows();
  }

  void render(Renderer r) {
    r.renderCircle(pos);
  }
}
