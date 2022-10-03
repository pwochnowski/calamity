import 'dart:html';

import 'package:calamity/src/scene/player.dart';

import '../math/vector2.dart';
import 'mouse.dart';

enum MouseButton { LEFT, RIGHT }

class InputState {
  final Set<int> heldDownKeys = new Set();
  Set<int> keysThisFrame = new Set();

  // current mouse
  MouseState? mouse;

  bool getKeyState(int key) => heldDownKeys.contains(key);

  void beginNewFrame() {
    keysThisFrame.clear();
  }

  static final List<int> _kc = [32, 37, 38, 39, 40];
  void registerListeners(CanvasElement canvas) {
    window.onKeyDown.listen((ev) {
      // track held keys
      heldDownKeys.add(ev.keyCode);
      keysThisFrame.add(ev.keyCode);
      if (_kc.contains(ev.keyCode)) {
        ev.preventDefault();
      }
    });

    window.onKeyUp.listen((ev) {
      heldDownKeys.remove(ev.keyCode);
      ev.preventDefault();
    });

    // FIXME: We should be updating whenever the hover position is changed.
    canvas.onMouseMove.listen((event) {});
    canvas.onMouseDown.listen((event) {
      mouse = new MouseState(event);
    });
    window.onContextMenu.listen((event) {
      print("context");
      event.preventDefault();
    });
  }

  bool _hasHeldDownAny(List<int> keys) => keys.any(heldDownKeys.contains);

  PlayerInputState derivePlayerInputState(PlayerInputState old) {
    Set<PlayerKey> keys = new Set();
    if (_hasHeldDownAny([KeyCode.LEFT, KeyCode.A])) {
      keys.add(PlayerKey.LEFT);
    }
    if (_hasHeldDownAny([KeyCode.RIGHT, KeyCode.D])) {
      keys.add(PlayerKey.RIGHT);
    }
    if (_hasHeldDownAny([KeyCode.UP, KeyCode.W])) {
      keys.add(PlayerKey.UP);
    }
    if (_hasHeldDownAny([KeyCode.DOWN, KeyCode.S])) {
      keys.add(PlayerKey.DOWN);
    }

    if (keysThisFrame.contains(KeyCode.E)) {
      keys.add(PlayerKey.DASH);
    }

    if (keysThisFrame.contains(KeyCode.SPACE)) {
      keys.add(PlayerKey.SHOOT);
    }

    if (keysThisFrame.contains(KeyCode.M)) {
      keys.add(PlayerKey.MUTE);
    }

    PlayerInputState ps = new PlayerInputState(mouse ?? MouseState.NONE, keys);
    mouse = null;
    return ps;
  }
}

typedef void EventHandler<E extends Event>(E);
// EventHandler<E> evh<E extends Event>(E ev) {}

enum PlayerKey {
  LEFT,
  RIGHT,
  UP,
  DOWN,
  DASH,
  SHOOT,
  MUTE,
}

class PlayerInputState {
  // Probably need this as is
  MouseState mouse;
  final Set<PlayerKey> keys;

  PlayerInputState(this.mouse, this.keys);
}
