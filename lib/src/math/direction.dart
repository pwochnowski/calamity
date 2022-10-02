import 'package:calamity/src/math/vector2.dart';

enum Direction {
  RIGHT,
  BOTTOMRIGHT,
  BOTTOM,
  BOTTOMLEFT,
  LEFT,
  TOPLEFT,
  TOP,
  TOPRIGHT,
}

Direction? directionFromVec(Vector2 dir) {
  final double directionThres = 0.4;
  if (dir.length2() == 0) {
    return null;
  }
  dir = dir.normalized();

  if (dir.x.abs() < directionThres) {
    return dir.y > 0 ? Direction.BOTTOM : Direction.TOP;
  }

  int dirY = dir.y > directionThres ? 1 : dir.y > - directionThres ? 0 : -1;
  return directionFromInt(dir.x > 0 ? 8 + dirY : 4 - dirY);
}

Direction directionFromInt(int dir) {
  switch(dir % 8) {
  case 0:
    return Direction.RIGHT;
  case 1:
    return Direction.BOTTOMRIGHT;
  case 2:
    return Direction.BOTTOM;
  case 3:
    return Direction.BOTTOMLEFT;
  case 4:
    return Direction.LEFT;
  case 5:
    return Direction.TOPLEFT;
  case 6:
    return Direction.TOP;
  default:
    return Direction.TOPRIGHT;
  }
}

int intFromDirection(Direction dir) {
  switch (dir) {
  case Direction.RIGHT:
    return 0;
  case Direction.BOTTOMRIGHT:
    return 1;
  case Direction.BOTTOM:
    return 2;
  case Direction.BOTTOMLEFT:
    return 3;
  case Direction.LEFT:
    return 4;
  case Direction.TOPLEFT:
    return 5;
  case Direction.TOP:
    return 6;
  case Direction.TOPRIGHT:
    return 7;
  }
}

void testDirs() {
  for (int dx = -1; dx < 2; ++dx) {
    for (int dy = -1; dy < 2; ++dy) {
      Vector2 v = new Vector2(dx, dy);
      print("${v.x} ${v.y} ${directionFromVec(v)}");
    }
  }
}