import 'package:calamity/src/inputs/input_state.dart';
import 'package:calamity/src/math/aabb.dart';
import 'package:calamity/src/math/color.dart';
import 'package:calamity/src/math/vector2.dart';
import 'package:calamity/src/render/renderer.dart';
import 'package:calamity/src/scene/game_object.dart';

class Feeder extends GameObject {
  final Vector2 pos;
  final Vector2 size;
  final Vector2 halfSize;

  Feeder(this.pos, this.size): this.halfSize = size.halved();

  @override
  void render(Renderer r) {
    r.renderRectangle(pos - halfSize, size, Color.YELLOW, fill: true);
  }

  @override
  void update(PlayerInputState input, num deltaTime) {
    // TODO: implement update
  }

  AABB getBounds() {
    return AABB.fromLocAndSize(pos, size);
  }
}
