import 'dart:math';

class Vector2 {
  final num x, y;

  Vector2(this.x, this.y);

  static Vector2 avg(List<Vector2> vs) {

    Vector2 u = new Vector2(0,0);
    for (Vector2 v in vs) {
      u = u + v;
    }
    return u / vs.length;
  }

  Vector2 operator +(Vector2 other) {
    return new Vector2(x + other.x, y + other.y);
  }

  Vector2 operator -(Vector2 other) {
    return new Vector2(x - other.x, y - other.y);
  }

  Vector2 operator -() {
    return new Vector2(-x, -y);
  }

  Vector2 operator *(num s) {
    return new Vector2(x * s, y * s);
  }

  Vector2 operator /(num s) {
    return new Vector2(x / s, y / s);
  }

  Vector2 normalized() {
    num l = length();
    return l == 0 ? this : this / length();
  }

  num length() {
    return sqrt(x * x + y * y);
  }

  @override
  String toString() {
    return "${x.toStringAsFixed(3)}, ${y.toStringAsFixed(3)}";
  }
}
