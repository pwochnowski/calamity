import 'package:calamity/src/math/vector2.dart';
import 'package:calamity/src/render/renderer.dart';
import 'package:calamity/src/scene/game_arena.dart';

import '../inputs/input_state.dart';

class ScoreWidget {
  final Vector2 pos = new Vector2(2, 16);
  late GameArena arena;
  int score = 0;

  void update(PlayerInputState input, num deltaTime) {
    score += deltaTime.ceil();
  }

  void add(int delta) => score += delta;

  void render(Renderer r) {
    r.renderText("Score: $score", pos, Justification.LEFT);
  }

  void reset() {
    score = 0;
  }
}