
import 'package:calamity/src/scene/player.dart';

import '../inputs/input_state.dart';
import '../math/vector2.dart';
import '../render/renderer.dart';
import 'game_arena.dart';

class Model {
  final GameArena arena;
  final num width;
  final num height;

  Model(this.width, this.height): arena = new GameArena(width, height);

  void update(PlayerInputState input) {
    arena.update(input);
  }

  void render(Renderer r) {
    arena.render(r);
  }

}
