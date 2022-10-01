import 'dart:html';

import '../math/vector2.dart';

class Mouse {
  final MouseEvent? event;
  final bool left;
  final bool middle;
  final bool right;
  final Vector2? pos;

  static final NONE = Mouse(null);

  Mouse(this.event) :
    left = event?.button == 0,
        middle = event?.button == 1,
        right = event?.button == 2,
        pos = event != null ? new Vector2(event.offset.x, event.offset.y) : null
    ;
}