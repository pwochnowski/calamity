import 'package:calamity/src/math/vector2.dart';
import 'package:calamity/src/render/renderer.dart';
import 'package:calamity/src/scene/game_arena.dart';

import '../inputs/input_state.dart';

class AmmoWidget {
  final Vector2 pos = new Vector2(2, 32);
  late GameArena arena;

  void render(Renderer r) {
    r.renderText("Bird seed ammo: ${arena.player.ammo}", pos, Justification.LEFT);
  }
}
