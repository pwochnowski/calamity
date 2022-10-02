import 'dart:math';

import '../math/static.dart';
import '../math/vector2.dart';
import 'animation_resource.dart';

class Animation {
  final GetterT<AnimationResource> resourceGetter;
  final List<int> frames;

  Animation(this.resourceGetter, this.frames);
}

class AnimationInstance {
  Animation animation;
  Vector2 pos;
  Vector2 size;
  final num timeStep;
  num elapsed = 0;

  AnimationInstance(this.animation, this.pos, this.size, this.timeStep);

  void updateElapsed(num delta) => elapsed += delta;

  int _frameNumber() => (elapsed / timeStep).ceil();
  bool hasEnded() => _frameNumber() >= animation.frames.length;
  int frameNumber() => _frameNumber() % animation.frames.length;
  int currentFrame() => animation.frames[frameNumber()];
}
