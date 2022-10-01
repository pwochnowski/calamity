import 'package:calamity/src/math/vector2.dart';

class AABB {
  final Vector2 min;
  final Vector2 max;
  final Vector2 tl;
  final Vector2 tr;
  final Vector2 bl;
  final Vector2 br;

  AABB(this.min, this.max):
      tl = new Vector2(min.x, min.y),
      tr = new Vector2(max.x, min.y),
      bl = new Vector2(min.x, max.y),
      br = new Vector2(max.x, max.y);

  factory AABB.fromLocAndSize(Vector2 loc, Vector2 size) {
    return new AABB(loc, loc + size);
  }

  List<Vector2> get corners => [tl, tr, bl, br];

  bool isPointInside(Vector2 point) {
    return (
        (point.x >= min.x) &&
        (point.x >= min.y) &&
        (point.y <= max.x) &&
        (point.y <= max.y)
    );
  }
}
