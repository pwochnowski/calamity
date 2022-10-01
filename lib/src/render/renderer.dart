import 'dart:html';
import 'dart:math';

import '../math/vector2.dart';

class Renderer {
  final CanvasRenderingContext2D ctx;
  final CanvasElement canvas;

  num get width => canvas.width!;
  num get height => canvas.height!;

  Renderer(this.canvas) : ctx = canvas.context2D;

  void beginRender() {
    ctx.clearRect(0, 0, width, height);
  }

  void renderCircle(Vector2 v) {
    ctx.arc(v.x, v.y, 10.0, 0.0, 2 * pi);
    ctx.stroke();
  }

}
