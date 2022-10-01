
import 'dart:html';

import '../math/vector2.dart';

enum MouseButton {
  LEFT,
  RIGHT
}

class InputState {
  final Set<int> heldDownKeys = new Set();
  Set<int> keysThisFrame = new Set();
  MouseEvent? _lastMouseEvent;

  bool getKeyState(int key) => heldDownKeys.contains(key);

  MouseEvent? getLastMouseEvent() => _lastMouseEvent;

  void beginNewFrame() {
    keysThisFrame.clear();
  }

  Vector2 getDirectionFromArrows() {
    List<Vector2> dirs = [Vector2(0,0)];
    for (int key in heldDownKeys) {
      switch (key) {
        case KeyCode.LEFT:
          dirs.add(new Vector2(-1, 0));
          break;
        case KeyCode.RIGHT:
          dirs.add(new Vector2(1, 0));
          break;
        case KeyCode.DOWN:
          dirs.add(new Vector2(0, 1));
          break;
        case KeyCode.UP:
          dirs.add(new Vector2(0, -1));
          break;
      }
    }
    return Vector2.avg(dirs);
  }


  void registerListeners() {

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
      _lastMouseEvent = event;
    });
  }


  PlayerInputState derivePlayerInputState() {
    return new PlayerInputState(getLastMouseEvent());
  }
}

typedef void EventHandler<E extends Event>(E);
// EventHandler<E> evh<E extends Event>(E ev) {}

class PlayerInputState {
  // Probably need this as is
  final MouseEvent? lastMouseEvent;

  PlayerInputState(this.lastMouseEvent);
}
