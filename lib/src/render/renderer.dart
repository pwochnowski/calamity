import 'dart:html';
import 'dart:math';

import 'package:calamity/src/resources/image_resource.dart';

import '../math/vector2.dart';

class Renderer {
  final CanvasRenderingContext2D ctx;
  final CanvasElement canvas;

  num get width => canvas.width!;
  num get height => canvas.height!;

  Renderer(this.canvas) : ctx = canvas.context2D {
  }

  void beginRender() {
    ctx.clearRect(0, 0, width, height);
  }

  void renderCircle(Vector2 v) {
    ctx.beginPath();
    ctx.arc(v.x, v.y, 10.0, 0.0, 2 * pi);
    ctx.stroke();
  }

  void renderImage(Vector2 pos, Vector2 size, ImageResource image) {
    // Hack: The actual JS function allows an ImageBitmap to be passed in
    ctx.drawImageScaled(image.bitmap, pos.x, pos.y, size.x, size.y);
  }
}
