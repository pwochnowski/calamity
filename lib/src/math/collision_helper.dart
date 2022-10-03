import 'dart:math';

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

  /// returns how much to shift to move c1 out of c2
  static bool collidesCircleCircle(Vector2 c1, num r1, Vector2 c2, num r2) {
    num dist2 = c1.distanceTo2(c2);
    num rsum2 = pow(r1 + r2, 2);
    return dist2 <= rsum2;
  }

  /// returns how much to shift to move c1 out of c2
  static Vector2? shiftVectorCircleCircle(Vector2 c1, num r1, Vector2 c2, num r2) {
    num dist2 = c1.distanceTo2(c2);
    num rsum2 = pow(r1 + r2, 2);
    if (dist2 > rsum2) {
      return null; // the two circles don't collide
    }

    num intersectDist = (r1 + r2) - c1.distanceTo(c2);
    Vector2 direction = c1 - c2;
    return direction.normalized() * intersectDist;
  }
}
