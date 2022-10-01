/// Support for doing something awesome.
///
/// More dartdocs go here.
library calamity;

import 'package:calamity/src/inputs/input_state.dart';
import 'package:calamity/src/main_ctx.dart';
import 'dart:html';


export 'src/calamity_base.dart';

Future<void> clientMain() async {

  MainCtx mainctx = setupMainCtx();

  while (true) {
    mainctx.doFrame();
    await window.animationFrame;
  }
}

MainCtx setupMainCtx() {
  CanvasElement canvas = document.getElementById('game-canvas')! as CanvasElement;
  InputState inputs = new InputState();
  inputs.registerListeners();


  MainCtx mainctx = new MainCtx(canvas, inputs);
  return mainctx;
}
