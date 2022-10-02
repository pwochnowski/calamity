
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

  void update(PlayerInputState input, num deltaTime) {
    // print("ARENA UPDATE: ${input.mouse?.event.button} ${arena.playing}");
    if (arena.playing) {
      // print("Areana update ${arena.hashCode}");
      arena.update(input, deltaTime);
    } else {
      // FIXME: There are many places this line of code could belong, this is not one of them
      ggScreen.setScore(arena.lastScore);
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
