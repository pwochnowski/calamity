import 'package:calamity/src/inputs/input_state.dart';
import 'package:calamity/src/math/aabb.dart';
import 'package:calamity/src/math/color.dart';
import 'package:calamity/src/math/vector2.dart';
import 'package:calamity/src/render/renderer.dart';
import 'package:calamity/src/resources/image_resource.dart';
import 'package:calamity/src/scene/game_object.dart';

import '../resources/resources.dart';

class Feeder extends GameObject {
  final Vector2 pos;
  final Vector2 size;

  int _originalSeeds = 0;
  int _remainingSeeds = 0;

  Feeder(this.pos, this.size) {
    _originalSeeds = (size.x * size.y) ~/ (50 * 50);
    _remainingSeeds = _originalSeeds;
  }

  bool hasRemainingSeeds() {
    return _remainingSeeds > 0;
  }

  @override
  void render(Renderer r) {
    num alpha = _remainingSeeds * 1.0 / _originalSeeds;
    r.ctx.globalAlpha = alpha;
    r.ctx.drawImageScaledFromSource(_image.bitmap, 0, 0, size.x / 2, size.y / 2, pos.x - (size.x / 2),
        pos.y - (size.y / 2), size.x, size.y);
    r.ctx.globalAlpha = 1.0;
  }

  bool tryTakeSeed() {
    if (!hasRemainingSeeds()) {
      return false;
    }
    _remainingSeeds -= 1;
    return true;
  }

  @override
  void update(PlayerInputState input, num deltaTime) {
    // TODO: implement update
  }

  AABB getBounds() {
    return AABB.fromLocAndSize(pos, size);
  }

  ImageResource get _image => Resources.GameResources.getResource(Resources.GRAINS);
}
