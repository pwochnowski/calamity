import 'package:calamity/src/resources/animation_frame.dart';
import 'package:calamity/src/scene/bullet_spawner.dart';

import '../render/renderer.dart';
import '../math/vector2.dart';
import '../inputs/input_state.dart';
import './game_object.dart';
import 'game_arena.dart';

class Shotgun extends GameObject {
  Vector2 pos;
  num bulletDirection;
  GameArena _enclosingArena;
  late AnimationInstance _animationInstance;
  static final Vector2 size = new Vector2(100, 100);
  bool hasFired = false;

  Shotgun(this.pos, this.bulletDirection, this._enclosingArena,
      Animation animation, num rotation) {
    _animationInstance = new AnimationInstance(animation, pos, size, 200);
    _animationInstance.rotation = rotation;
  }

  @override
  void render(Renderer r) {
    r.renderAnimation(_animationInstance);
  }

  @override
  void update(PlayerInputState input, num deltaTime) {
    _animationInstance.updateElapsed(deltaTime);
    if (_animationInstance.frameNumber() >= 3) {
      _enclosingArena.bullets.add(
          BulletSpawner.createNewBullet(pos, bulletDirection, _enclosingArena));
      _enclosingArena.standaloneAnimations.add(_animationInstance);
      hasFired = true;
    }
  }
}
