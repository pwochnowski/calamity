
import 'package:calamity/src/math/vector2.dart';

class LineSeg {
  static final LineSeg ZERO = new LineSeg(Vector2.ZERO, Vector2.ZERO);

  final Vector2 start;
  final Vector2 end;

  LineSeg(this.start, this.end);

  Vector2 relative() => end - start;
  Vector2 dir() => relative().normalized();
  
  num length() => start.distanceTo(end);

  num ratioOnSeg(Vector2 v) {
    Vector2 seg = (v - start);
    num dotProd = seg.dotProd(dir());
    Vector2 proj = start + dir() * dotProd;
    return (proj -start).length() / length();
  }
  
}