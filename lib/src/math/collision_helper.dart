import 'package:calamity/src/math/aabb.dart';
import 'package:calamity/src/math/vector2.dart';

/// static functions for collision detection
class CollisionHelper {

  /// tests circle-AABB for collision
  static bool collidesCircleAABB(Vector2 circleLoc, num radius, AABB aabb) {
    num radius2 = radius * radius;
    if (aabb.isPointInside(circleLoc)) {
      return true;
    }
    if (circleLoc.x >= aabb.min.x && circleLoc.x <= aabb.max.x) {
      if (circleLoc.y + radius >= aabb.min.y && circleLoc.y - radius <= aabb.max.y) {
        return true;
      }
    }
    if (circleLoc.y >= aabb.min.y && circleLoc.y <= aabb.max.y) {
      if (circleLoc.x + radius >= aabb.min.x && circleLoc.x - radius <= aabb.max.x) {
        return true;
      }
    }
    for (Vector2 corner in aabb.corners) {
      if (circleLoc.distanceTo2(corner) <= radius2) {
        return true;
      }
    }
    return false;
  }
}
