import 'dart:html';
import 'dart:math';

import 'package:calamity/src/resources/animation_resource.dart';
import 'package:calamity/src/resources/image_resource.dart';

import '../math/static.dart';
import '../math/vector2.dart';

enum Justification {
  LEFT,
  CENTER,
  RIGHT,
}

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

  void renderText(String text, Vector2 position, Justification justification) {
    switch (justification) {
      case Justification.LEFT:
        ctx.textAlign = "left";
        break;
      case Justification.CENTER:
        ctx.textAlign = "center";
        break;
      case Justification.RIGHT:
        ctx.textAlign = "right";
        break;
    }
    ctx.strokeText(text, position.x, position.y);
  }

  void renderCircle(Vector2 v) {
    ctx.beginPath();
    ctx.arc(v.x, v.y, 10.0, 0.0, 2 * pi);
    ctx.stroke();
  }

  void renderSemiCircle(Vector2 v) {
    ctx.beginPath();
    double beginRadians = StaticData.random.nextDouble() * 2 * pi;
    ctx.arc(v.x, v.y, 10.0, StaticData.random.nextDouble() * 2 * pi, beginRadians + pi);
    ctx.stroke();
  }

  void renderImage(Vector2 pos, Vector2 size, ImageResource image) {
    ctx.drawImageScaled(image.bitmap, pos.x - (size.x / 2), pos.y - (size.y / 2), size.x, size.y);
  }

  void renderAnimationFrame(Vector2 pos, Vector2 size, AnimationResource resource, int index) {
    resource.renderFrame(ctx, index, pos - (size / 2), size);
  }
}
