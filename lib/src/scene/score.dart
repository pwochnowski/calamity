import 'package:calamity/src/math/vector2.dart';
import 'package:calamity/src/render/renderer.dart';
import 'package:calamity/src/scene/game_arena.dart';

import '../inputs/input_state.dart';

class PlayerScore {
  int score = 0;
  int chicksSaved = 0;
  int foxesKilled = 0;
  // In ms
  int timeSurvived = 0;
}

class ScoreWidget {
  final Vector2 pos = new Vector2(2, 16);
  late GameArena arena;
  PlayerScore score = new PlayerScore();

  void update(PlayerInputState input, num deltaTime) {
    score.score += deltaTime.ceil();
    score.timeSurvived += deltaTime.ceil();
  }

  void add(int delta) => score.score += delta;
  void addKilledFox() => score.foxesKilled += 1;
  void addSavedChick() => score.chicksSaved += 1;

  void render(Renderer r) {
    r.renderText("Score: $score", pos, Justification.LEFT);
  }

  void reset() {
    score = new PlayerScore();
  }
}
