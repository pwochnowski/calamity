import 'dart:math';

class Vector2 {
  final num x, y;

  Vector2(this.x, this.y);

  Vector2 setX(num newX) {
    return new Vector2(newX, y);
  }

  Vector2 setY(num newY) {
    return new Vector2(x, newY);
  }

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

  num length2() {
    return x*x + y*y;
  }

  @override
  String toString() {
    return "${x.toStringAsFixed(3)}, ${y.toStringAsFixed(3)}";
  }

  num distanceTo(Vector2 v) {
    return (this - v).length();
  }
  num distanceTo2(Vector2 v) {
    return (this - v).length2();
  }

  num dotProd(Vector2 v) {
    return v.x*x + v.y*y;
  }

  Vector2 round() {
    return new Vector2(x.round(), y.round());
  }
}
