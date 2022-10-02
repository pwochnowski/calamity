import 'package:calamity/src/resources/animation_resource.dart';

import '../math/static.dart';
import 'animation_frame.dart';

class PlayerAnimationManifest {
  final GetterT<AnimationResource> _resourceGetter;
  late final Animation moveTopRight;
  late final Animation moveBottomLeft;
  late final Animation moveBottom;
  late final Animation moveTop;
  late final Animation moveLeft;
  late final Animation idle;

  PlayerAnimationManifest(this._resourceGetter) {
    moveTopRight = new Animation(_resourceGetter, [11, 12, 13, 14]);
    moveBottomLeft = new Animation(_resourceGetter, [20, 21, 22, 23]);
    moveBottom = new Animation(_resourceGetter, [28, 29, 30, 31]);
    moveTop = new Animation(_resourceGetter, [36, 37, 38, 39]);
    moveLeft = new Animation(_resourceGetter, [44, 45, 46, 47]);
    idle = new Animation(_resourceGetter, [49, 50, 51, 52]);
  }
}