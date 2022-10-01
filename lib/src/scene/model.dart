
import 'package:calamity/src/scene/player.dart';

import '../inputs/input_state.dart';
import '../math/vector2.dart';
import '../render/renderer.dart';
import 'game_arena.dart';

class Model {
  final GameArena arena;

  Model(): arena = new GameArena();

  void handleInputs(PlayerInputState input) {
    arena.handleInputs(input);
  }

  void render(Renderer r) {
    arena.render(r);
  }

}
