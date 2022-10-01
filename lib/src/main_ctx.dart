
import 'dart:html';

import 'package:calamity/src/render/renderer.dart';
import 'package:calamity/src/scene/model.dart';

import 'inputs/input_state.dart';

class MainCtx {
  final CanvasElement canvas;
  final Renderer renderer;
  final Model model;
  final InputState inputState;

  MainCtx(this.canvas, this.inputState) :
    renderer = new Renderer(canvas),
    model = new Model()
    ;



  void doFrame() {
    inputState.beginNewFrame();
    renderer.beginRender();

    model.handleInputs(inputState);

    model.render(renderer);
  }
}



