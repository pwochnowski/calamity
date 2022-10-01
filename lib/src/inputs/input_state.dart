
import 'dart:html';

import '../math/vector2.dart';

class InputState {
  final Set<int> heldDownKeys = new Set();
  Set<int> keysThisFrame = new Set();

  bool getKeyState(int key) => heldDownKeys.contains(key);

  void beginNewFrame() {
    print("Pressed ${keysThisFrame} ${KeyCode.DOWN}");
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
          dirs.add(new Vector2(0, -1));
          break;
        case KeyCode.UP:
          dirs.add(new Vector2(0, 1));
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
  }


}

typedef void EventHandler<E extends Event>(E);
// EventHandler<E> evh<E extends Event>(E ev) {}

class PlayerInputState {

}
