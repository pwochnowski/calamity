
import 'dart:html';

import 'package:calamity/src/scene/player.dart';

import '../math/vector2.dart';
import 'mouse.dart';

enum MouseButton {
  LEFT,
  RIGHT
}

class InputState {
  final Set<int> heldDownKeys = new Set();
  Set<int> keysThisFrame = new Set();

  // current mouse
  Mouse? mouse;

  bool getKeyState(int key) => heldDownKeys.contains(key);

  void beginNewFrame() {
    keysThisFrame.clear();
  }

  void registerListeners(CanvasElement canvas) {

    window.onKeyDown.listen((ev) {
      keysThisFrame.add(ev.keyCode);

      // track held keys
      switch (ev.keyCode) {
        case KeyCode.LEFT:
        case KeyCode.RIGHT:
        case KeyCode.DOWN:
        case KeyCode.UP:
          heldDownKeys.add(ev.keyCode);
          break;
      }
    });

    window.onKeyUp.listen((ev) {
      switch (ev.keyCode) {
        case KeyCode.LEFT:
        case KeyCode.RIGHT:
        case KeyCode.DOWN:
        case KeyCode.UP:
          heldDownKeys.remove(ev.keyCode);
          break;
      }
    });

    window.onMouseMove.listen((event) {
    });
    window.onMouseDown.listen((event) {
      mouse = new Mouse(event);
      event.preventDefault();

    });
    window.onContextMenu.listen((event) {event.preventDefault();});
  }


  PlayerInputState derivePlayerInputState(PlayerInputState old) {

    Set<PlayerKey> keys = new Set();
    if (heldDownKeys.contains(KeyCode.LEFT)) { keys.add(PlayerKey.LEFT); }
    if (heldDownKeys.contains(KeyCode.RIGHT)) { keys.add(PlayerKey.RIGHT); }
    if (heldDownKeys.contains(KeyCode.UP)) { keys.add(PlayerKey.UP); }
    if (heldDownKeys.contains(KeyCode.DOWN)) { keys.add(PlayerKey.DOWN); }

    PlayerInputState ps = new PlayerInputState(mouse ?? Mouse.NONE, keys);
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
}

class PlayerInputState {
  // Probably need this as is
  Mouse mouse;
  final Set<PlayerKey> keys;

  PlayerInputState(this.mouse, this.keys);

}
