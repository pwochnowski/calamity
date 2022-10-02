
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
  MouseState? mouse;

  bool getKeyState(int key) => heldDownKeys.contains(key);

  void beginNewFrame() {
    keysThisFrame.clear();
  }

  void registerListeners(CanvasElement canvas) {

    window.onKeyDown.listen((ev) {
      // track held keys
      switch (ev.keyCode) {
        case KeyCode.LEFT:
        case KeyCode.RIGHT:
        case KeyCode.DOWN:
        case KeyCode.UP:
          heldDownKeys.add(ev.keyCode);
          break;
      }
      if (ev.code == 'KeyE') {
        keysThisFrame.add(KeyCode.E);
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

    // FIXME: We should be updating whenever the hover position is changed.
    canvas.onMouseMove.listen((event) {
    });
    canvas.onMouseDown.listen((event) {
      mouse = new MouseState(event);
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
    if (heldDownKeys.contains(KeyCode.E)) { keys.add(PlayerKey.DASH); }

    if (keysThisFrame.contains(KeyCode.E)) {
      keys.add(PlayerKey.DASH);
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
}

class PlayerInputState {
  // Probably need this as is
  MouseState mouse;
  final Set<PlayerKey> keys;

  PlayerInputState(this.mouse, this.keys);

}
