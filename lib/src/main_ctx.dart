
import 'dart:html';

import 'package:calamity/src/render/renderer.dart';
import 'package:calamity/src/scene/model.dart';

import 'inputs/input_state.dart';

class MainCtx {
  final CanvasElement canvas;
  final Renderer renderer;
  final Model model;
  final InputState inputState;
  PlayerInputState lastInputState = new PlayerInputState(null, new Set());

  MainCtx(this.canvas, this.inputState) :
    renderer = new Renderer(canvas),
    model = new Model(canvas.width!, canvas.height!);

  /// performs a single update-render loop cycle
  /// [deltaTime] is the amount of time passed since the last frame
  void doFrame(num deltaTime) {
    inputState.beginNewFrame();
    PlayerInputState newInputState = inputState.derivePlayerInputState(lastInputState);
    model.update(newInputState, deltaTime);

    renderer.beginRender();
    model.render(renderer);
    lastInputState = newInputState;
  }
}
