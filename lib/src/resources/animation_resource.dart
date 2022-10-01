import 'dart:html';

import 'package:calamity/src/math/vector2.dart';
import 'package:calamity/src/resources/resources.dart';

/// sprite sheet animation with frames tiled horizontally then vertically.
/// each frame is of a fixed size
class AnimationResource implements Resource {
  final ImageElement image;
  final int frameWidth;
  final int frameHeight;
  final int frameRows;
  final int frameCols;

  AnimationResource(this.image, this.frameWidth, this.frameHeight, this.frameRows, this.frameCols);

  static Future<AnimationResource> load(String resourcePath, int frameWidth, int frameHeight) async {
    ImageElement image = new ImageElement(src: resourcePath);
    await image.decode();
    int frameRows = (image.height ?? 0) ~/ frameHeight;
    int frameCols = (image.width ?? 0) ~/ frameWidth;
    return new AnimationResource(image, frameWidth, frameHeight, frameRows, frameCols);
  }

  /// invariant: render functions can change the ctx arbitrarily such as ctx.rotate
  /// but must restore the ctx back to the initial state at the end
  void renderFrame(CanvasRenderingContext2D ctx, int index, Vector2 pos, Vector2 size,
      {double rotation: 0.0}) {
    int srcR = index ~/ frameCols;
    int srcC = index & frameCols;
    int srcX = srcC * frameWidth;
    int srcY = srcR * frameHeight;
    ctx.drawImageScaledFromSource(image, srcX, srcY, frameWidth, frameHeight, pos.x, pos.y, size.x, size.y);
  }
}
