
import 'package:calamity/src/scene/player.dart';

import '../inputs/input_state.dart';
import '../math/vector2.dart';
import '../render/renderer.dart';
import 'game_arena.dart';
import 'gg_screen.dart';

class Model {
  final GameArena arena;
  final GameOverScreen ggScreen;
  final num width;
  final num height;

  Model(this.width, this.height)  :
    arena = new GameArena(width, height),
    ggScreen = new GameOverScreen() {

    ggScreen.arena = arena;
  }

  void update(PlayerInputState input) {
    if (arena.playing) {
      arena.update(input);
    } else {
      ggScreen.update(input);
    }
  }

  void render(Renderer r) {
    if (arena.playing) {
      arena.render(r);
    } else {
      ggScreen.render(r);
    }
  }

}
