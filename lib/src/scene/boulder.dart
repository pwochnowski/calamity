import 'package:calamity/src/inputs/input_state.dart';
import 'package:calamity/src/math/vector2.dart';
import 'package:calamity/src/render/renderer.dart';
import 'package:calamity/src/scene/game_object.dart';

import '../resources/image_resource.dart';
import '../resources/resources.dart';

class Boulder extends GameObject {
  Vector2 pos;
  Vector2 halfSize = new Vector2(20, 20);
  double radius = 20;

  Boulder(this.pos);

  @override
  void update(PlayerInputState input, num deltaTime) {
    // TODO: implement update
  }

  @override
  void render(Renderer r) {
    r.renderImage(pos - halfSize, halfSize * 2, _image);
  }

  ImageResource get _image => Resources.GameResources.getResource(Resources.BOULDER);
}
