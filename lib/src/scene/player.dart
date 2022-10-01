
import 'package:calamity/src/resources/image_resource.dart';

import '../inputs/input_state.dart';
import '../math/vector2.dart';
import '../render/renderer.dart';
import '../resources/resources.dart';

class Player {
  ImageResource? _playerImage;

  Vector2 pos;
  Vector2 imageBounds = new Vector2(50, 50);

  Player(this.pos);

  void handleInput(InputState inputs) {
    pos += inputs.getDirectionFromArrows();
  }

  void render(Renderer r) {
    //r.renderCircle(pos);
    r.renderImage(pos, imageBounds, getPlayerImage());
  }

  ImageResource getPlayerImage() => _playerImage ??= Resources.GameResources.getResource('player') as ImageResource;
}
