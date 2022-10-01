
import 'package:calamity/src/scene/player.dart';

import '../inputs/input_state.dart';
import '../math/vector2.dart';
import '../render/renderer.dart';

class Model {
  final Player player;

  Model() : player = new Player(new Vector2(0, 0));


  void handleInputs(InputState inputs) {
    player.handleInput(inputs);
  }

  void render(Renderer r) {
    player.render(r);
  }

}
