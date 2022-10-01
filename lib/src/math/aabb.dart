import 'package:calamity/src/math/vector2.dart';

class AABB {
  final Vector2 min;
  final Vector2 max;

  AABB(this.min, this.max);

  factory AABB.fromLocAndSize(Vector2 loc, Vector2 size) {
    return new AABB(loc, loc + size);
  }
}
