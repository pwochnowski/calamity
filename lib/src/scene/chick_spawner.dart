import 'package:calamity/src/inputs/input_state.dart';
import 'package:calamity/src/math/vector2.dart';
import 'package:calamity/src/render/renderer.dart';
import 'package:calamity/src/scene/game_arena.dart';

import '../constants.dart';
import '../math/segment.dart';
import 'chick.dart';

class ChickSpawner {
  late GameArena arena;
  num cooldown = Constants.CHICK_SPAWN_SECONDS * 1000; // millis
  int additionalChicksPerRound = 0;

  void reset() {
    cooldown = Constants.CHICK_SPAWN_SECONDS * 1000;
    additionalChicksPerRound = 0;
  }

  void update(PlayerInputState input, num deltaTime) {
    if (cooldown > 0) {
      cooldown -= deltaTime;
    } else {
      spawnChicks();
      cooldown = Constants.CHICK_SPAWN_SECONDS * 1000;
    }
  }

  void spawnChicks() {
    for (int i = 0; i < Constants.NUM_CHICKS + additionalChicksPerRound; i++) {
      Chick chick = Chick(
          arena,
          new LineSeg(
            new Vector2(400, 0),
            new Vector2.random(800, 400),
          ));

      arena.lostChicks.add(chick);
    }
    additionalChicksPerRound += 1;
  }

  void render(Renderer r) {
    Vector2 pos = new Vector2(arena.width / 2, 10);
    String text = "Next egg wave: ${(cooldown / 1000).toStringAsFixed(2)} s";
    r.renderText(text, pos, Justification.CENTER);
  }
}
