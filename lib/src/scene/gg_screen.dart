
import 'package:calamity/src/inputs/input_state.dart';

import '../render/renderer.dart';
import 'game_arena.dart';

class GameOverScreen {

  late GameArena arena;

  GameOverScreen();
  void update(PlayerInputState ps) {
    if (ps.mouse?.left ?? false) {
      print("Retry");
      arena.playing = true;
    }

  }

  void render(Renderer r) {
    print("Drawing gg");
    r.ctx.beginPath();
    r.ctx.setFillColorRgb(255, 0, 0);
    r.ctx.rect(0,0, r.width, r.height);
    r.ctx.stroke();
  }
}