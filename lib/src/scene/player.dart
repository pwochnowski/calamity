
import 'package:calamity/src/resources/image_resource.dart';
import 'package:calamity/src/scene/game_arena.dart';

import '../inputs/input_state.dart';
import '../math/vector2.dart';
import '../render/renderer.dart';
import '../resources/resources.dart';

class Player {
  ImageResource? _playerImage;
  // Effectively non-nullable
  GameArena? _enclosingArena;

  double movementSpeed = 10.0;
  Vector2 pos;
  Vector2 imageBounds = new Vector2(50, 50);

  Player(this.pos);

  void setArena(GameArena arena) => this._enclosingArena = arena;

  void move(PlayerInputState input) {
    double x = 0.0;
    double y = 0.0;
    if (input.keys.contains(PlayerKey.LEFT)) { x -= 1; }
    if (input.keys.contains(PlayerKey.RIGHT)) { x += 1; }
    if (input.keys.contains(PlayerKey.UP)) { y -= 1; }
    if (input.keys.contains(PlayerKey.DOWN)) { y += 1; }
    pos += new Vector2(x, y).normalized() * movementSpeed;
  }

  void update(PlayerInputState input) {
    move(input);
  }

  void render(Renderer r) {
    print("Render");
    //r.renderCircle(pos);
    r.renderImage(pos, imageBounds, getPlayerImage());
  }

  ImageResource getPlayerImage() => _playerImage ??= Resources.GameResources.getResource('player');
}
