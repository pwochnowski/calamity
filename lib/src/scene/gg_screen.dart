import 'package:calamity/src/inputs/input_state.dart';
import 'package:calamity/src/math/vector2.dart';
import 'package:calamity/src/scene/score.dart';

import '../constants.dart';
import '../render/renderer.dart';
import '../resources/resources.dart';
import 'game_arena.dart';

class GameOverScreen {
  static final Vector2 pos = size / 2;
  static final Vector2 size =
      new Vector2(Constants.CANVAS_WIDTH, Constants.CANVAS_HEIGHT);
  PlayerScore score = new PlayerScore();
  late GameArena arena;

  GameOverScreen();
  void update(PlayerInputState ps) {
    if (ps.mouse.left || ps.keys.contains(PlayerKey.SHOOT)) {
      arena.playing = true;
    }
  }

  void render(Renderer r) {
    r.renderImage(
        pos, size, Resources.GameResources.getResource(Resources.GAME_OVER));
    r.renderText(
        "Time survived: ${(score.timeSurvived / 1000).toStringAsFixed(2)}s",
        pos.addY(-30),
        Justification.CENTER);
    r.renderText("Chicks saved: ${score.chicksSaved}", pos.addY(30),
        Justification.CENTER);
    r.renderText("Foxes deterred: ${score.foxesKilled}", pos.addY(90),
        Justification.CENTER);
    r.renderText(
        "Total Score: ${score.score}", pos.addY(150), Justification.CENTER);
    r.renderText("Click or press spacebar to try again", pos.addY(210),
        Justification.CENTER);
  }

  void setScore(PlayerScore newScore) => score = newScore;
}
