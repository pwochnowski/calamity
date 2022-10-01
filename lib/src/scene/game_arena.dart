import 'package:calamity/src/scene/player.dart';

import '../inputs/input_state.dart';
import '../math/vector2.dart';
import '../render/renderer.dart';
import 'bullet.dart';

class GameArena {
  Player player;
  List<Bullet> bullets = [];
  GameArena() : player = new Player(new Vector2(50, 50)) {
    player.setArena(this);
  }

  void handleInputs(PlayerInputState input) {
    player.handleInput(input);
  }

  void render(Renderer r) {
    player.render(r);
  }
}