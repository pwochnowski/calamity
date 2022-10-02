import 'package:calamity/src/resources/animation_resource.dart';

import '../math/direction.dart';
import '../math/static.dart';
import '../math/vector2.dart';
import 'animation_frame.dart';

class PlayerAnimationManifest {
  final GetterT<AnimationResource> _resourceGetter;
  late final Animation moveTopLeft;
  late final Animation moveTopRight;
  late final Animation moveBottomLeft;
  late final Animation moveBottomRight;
  late final Animation moveBottom;
  late final Animation moveTop;
  late final Animation moveLeft;
  late final Animation moveRight;
  late final Animation idle;
  late final Animation featherFall;

  PlayerAnimationManifest(this._resourceGetter) {
    moveTopRight = new Animation(_resourceGetter, [0, 1, 2, 3]);
    moveTopLeft = new Animation(_resourceGetter, [4, 5, 6, 7]);
    moveBottomLeft = new Animation(_resourceGetter, [8, 9, 10, 11]);
    moveBottomRight = new Animation(_resourceGetter, [12, 13, 14, 15]);
    moveBottom = new Animation(_resourceGetter, [16, 17, 18, 19]);
    moveTop = new Animation(_resourceGetter, [20, 21, 22, 23]);
    moveLeft = new Animation(_resourceGetter, [24, 25, 26, 27]);
    moveRight = new Animation(_resourceGetter, [28, 29, 30, 31]);
    idle = new Animation(_resourceGetter, [32, 33, 34, 35]);
    featherFall = new Animation(_resourceGetter, [36, 37, 38, 39, 40, 41, 42]);
  }

  AnimationInstance newAnimationFromDirection(Direction? dir, Vector2 pos, Vector2 size, num timeStep) {
    Animation animation;
    switch (dir) {
      case Direction.RIGHT:
        animation = moveRight;
        break;
      case Direction.BOTTOMRIGHT:
        animation = moveBottomRight;
        break;
      case Direction.BOTTOM:
        animation = moveBottom;
        break;
      case Direction.BOTTOMLEFT:
        animation = moveBottomLeft;
        break;
      case Direction.LEFT:
        animation = moveLeft;
        break;
      case Direction.TOPLEFT:
        animation = moveTopLeft;
        break;
      case Direction.TOP:
        animation = moveTop;
        break;
      case Direction.TOPRIGHT:
        animation = moveTopRight;
        break;
      case null:
        animation = idle;
        break;
    }
    return new AnimationInstance(animation, pos, size, timeStep);
  }
}