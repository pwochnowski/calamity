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