
import 'package:calamity/src/math/vector2.dart';

class LineSeg {
  Vector2 start;
  Vector2 end;

  LineSeg(this.start, this.end);

  Vector2 relative() => end - start;
  Vector2 dir() => relative().normalized();
  
  num length() => start.distanceTo(end);

  num ratioOnSeg(Vector2 v) {
    num dotProd = (v - start).normalized().dotProd(dir());
    return dotProd;
  }
  
}