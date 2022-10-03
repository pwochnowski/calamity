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
    featherFall =
        new Animation(_resourceGetter, [36, 37, 38, 39, 40, 41, 42, 43]);
  }

  AnimationInstance newAnimationFromDirection(
      Direction? dir, Vector2 pos, Vector2 size, num timeStep) {
    switch (dir) {
      case Direction.RIGHT:
        return new AnimationInstance(moveRight, pos, size, timeStep);
      case Direction.BOTTOMRIGHT:
        return new AnimationInstance(moveBottomRight, pos, size, timeStep);
      case Direction.BOTTOM:
        return new AnimationInstance(moveBottom, pos, size, timeStep);
      case Direction.BOTTOMLEFT:
        return new AnimationInstance(moveBottomLeft, pos, size, timeStep);
      case Direction.LEFT:
        return new AnimationInstance(moveLeft, pos, size, timeStep);
      case Direction.TOPLEFT:
        return new AnimationInstance(moveTopLeft, pos, size, timeStep);
      case Direction.TOP:
        return new AnimationInstance(moveTop, pos, size, timeStep);
      case Direction.TOPRIGHT:
        return new AnimationInstance(moveTopRight, pos, size, timeStep);
      case null:
        return new AnimationInstance(idle, pos, size, timeStep);
    }
  }
}

class EnemyAnimationManifest {
  final GetterT<AnimationResource> _resourceGetter;
  late final Animation moveTopLeft;
  late final Animation moveTopRight;
  late final Animation moveBottomLeft;
  late final Animation moveBottomRight;
  late final Animation moveBottom;
  late final Animation moveTop;
  late final Animation moveLeft;
  late final Animation moveRight;

  List<int> _makeOffsets(int start) {
    return [start, start + 1, start + 2, start + 3, start + 4];
  }

  EnemyAnimationManifest(this._resourceGetter) {
    moveLeft = new Animation(_resourceGetter, _makeOffsets(0));
    moveRight = new Animation(_resourceGetter, _makeOffsets(5));
    moveBottom = new Animation(_resourceGetter, _makeOffsets(10));
    moveTop = new Animation(_resourceGetter, _makeOffsets(15));
    moveBottomLeft = new Animation(_resourceGetter, _makeOffsets(20));
    moveBottomRight = new Animation(_resourceGetter, _makeOffsets(25));
    moveTopLeft = new Animation(_resourceGetter, _makeOffsets(30));
    moveTopRight = new Animation(_resourceGetter, _makeOffsets(35));
  }

  AnimationInstance newAnimationFromDirection(
      Direction? dir, Vector2 pos, Vector2 size, num timeStep) {
    switch (dir) {
      case Direction.RIGHT:
        return new AnimationInstance(moveRight, pos, size, timeStep);
      case Direction.BOTTOMRIGHT:
        return new AnimationInstance(moveBottomRight, pos, size, timeStep);
      case Direction.BOTTOM:
        return new AnimationInstance(moveBottom, pos, size, timeStep);
      case Direction.BOTTOMLEFT:
        return new AnimationInstance(moveBottomLeft, pos, size, timeStep);
      case Direction.LEFT:
        return new AnimationInstance(moveLeft, pos, size, timeStep);
      case Direction.TOPLEFT:
        return new AnimationInstance(moveTopLeft, pos, size, timeStep);
      case Direction.TOP:
        return new AnimationInstance(moveTop, pos, size, timeStep);
      case Direction.TOPRIGHT:
        return new AnimationInstance(moveTopRight, pos, size, timeStep);
      case null:
        throw new FallThroughError();
    }
  }
}

class ChickAnimationManifest {
  final GetterT<AnimationResource> _resourceGetter;
  late final Animation moveBottomLeft;
  late final Animation moveBottomRight;
  late final Animation moveBottom;
  late final Animation moveLeft;
  late final Animation moveRight;
  late final Animation idle;

  ChickAnimationManifest(this._resourceGetter) {
    moveBottomLeft = new Animation(_resourceGetter, [8, 9, 8, 10]);
    moveBottomRight = new Animation(_resourceGetter, [5, 6, 5, 7]);
    moveBottom = new Animation(_resourceGetter, [2, 3, 4, 3]);
    moveLeft = new Animation(_resourceGetter, [11, 12]);
    moveRight = new Animation(_resourceGetter, [13, 14]);
    idle = new Animation(_resourceGetter, [0, 1]);
  }

  AnimationInstance newAnimationFromDirection(
      Direction? dir, Vector2 pos, Vector2 size, num timeStep) {
    switch (dir) {
      case Direction.RIGHT:
        return new AnimationInstance(moveRight, pos, size, timeStep);
      case Direction.BOTTOMRIGHT:
        return new AnimationInstance(moveBottomRight, pos, size, timeStep);
      case Direction.BOTTOM:
        return new AnimationInstance(moveBottom, pos, size, timeStep);
      case Direction.BOTTOMLEFT:
        return new AnimationInstance(moveBottomLeft, pos, size, timeStep);
      case Direction.LEFT:
        return new AnimationInstance(moveLeft, pos, size, timeStep);
      case Direction.TOPLEFT:
        return new AnimationInstance(moveBottomLeft, pos, size, timeStep);
      case Direction.TOP:
        return new AnimationInstance(moveBottom, pos, size, timeStep);
      case Direction.TOPRIGHT:
        return new AnimationInstance(moveBottomRight, pos, size, timeStep);
      case null:
        return new AnimationInstance(idle, pos, size, timeStep);
    }
  }
}

class BulletAnimationManifest {
  final GetterT<AnimationResource> _resourceGetter;
  late final Animation travelling;

  BulletAnimationManifest(this._resourceGetter) {
    travelling = new Animation(_resourceGetter, [0, 1, 2, 3]);
  }
}

class ShotgunAnimationManifest {
  final GetterT<AnimationResource> _resourceGetter;
  late final Animation fromLeft;
  late final Animation fromRight;
  late final Animation fromTop;
  late final Animation fromBottom;

  List<int> _framesFromOffset(int off) =>
      [off + 5, off + 4, off, off + 1, off + 2, off + 3, off + 4, off + 5];

  ShotgunAnimationManifest(this._resourceGetter) {
    fromRight = new Animation(_resourceGetter, _framesFromOffset(0));
    fromLeft = new Animation(_resourceGetter, _framesFromOffset(6));
    fromTop = new Animation(_resourceGetter, _framesFromOffset(12));
    fromBottom = new Animation(_resourceGetter, _framesFromOffset(18));
  }
}
