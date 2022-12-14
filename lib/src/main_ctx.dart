
import 'dart:html';

import 'package:calamity/src/inputs/mouse.dart';
import 'package:calamity/src/render/renderer.dart';
import 'package:calamity/src/scene/model.dart';

import 'inputs/input_state.dart';

class MainCtx {
  final CanvasElement canvas;
  final Renderer renderer;
  final Model model;
  final InputState inputState;
  PlayerInputState lastInputState = new PlayerInputState(MouseState.NONE, new Set());

  MainCtx(this.canvas, this.inputState) :
    renderer = new Renderer(canvas),
    model = new Model(canvas.width!, canvas.height!);

  /// performs a single update-render loop cycle
  /// [deltaTime] is the amount of time passed since the last frame
  void doFrame(num deltaTime) {
    PlayerInputState newInputState = inputState.derivePlayerInputState(lastInputState);
    model.update(newInputState, deltaTime);

    renderer.beginRender();
    model.render(renderer);
    lastInputState = newInputState;
    inputState.beginNewFrame();
  }

  /// called when the user first performs an interaction with the game
  /// e.g. clicking on the document or pressing a button on the keyboard
  ///
  /// this way, the audio can play without an exception
  void onFirstInteraction() {
    model.startAudioLoop();
  }
}
