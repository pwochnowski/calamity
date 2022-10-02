
import 'package:calamity/src/inputs/input_state.dart';
import 'package:calamity/src/math/vector2.dart';

import '../render/renderer.dart';
import 'game_arena.dart';

class GameOverScreen {
  int score = 0;
  late GameArena arena;

  GameOverScreen();
  void update(PlayerInputState ps) {
    if (ps.mouse.left) {
      arena.playing = true;
    }

  }

  void render(Renderer r) {
    String message1 = "GAME OVER. Your score was $score.";
    String message2 = "Click to try again";
    Vector2 pos = new Vector2(r.width / 2, r.height / 2);
    r.renderText(message1, pos.addY(-30), Justification.CENTER);
    r.renderText(message2, pos.addY(30), Justification.CENTER);
  }

  void setScore(int newScore) => score = newScore;
}