/// Support for doing something awesome.
///
/// More dartdocs go here.
library calamity;

import 'package:calamity/src/inputs/input_state.dart';
import 'package:calamity/src/main_ctx.dart';
import 'package:calamity/src/math/direction.dart';
import 'dart:html';

import 'package:calamity/src/resources/image_resource.dart';
import 'package:calamity/src/resources/resources.dart';

Future<void> clientMain() async {
  await Resources.GameResources.loadAll();
  MainCtx mainctx = setupMainCtx();

  bool interacted = false;
  void onInteraction() {
    if (interacted) {
      return;
    }
    mainctx.onFirstInteraction();
    interacted = true;
  }

  document.addEventListener('mousedown', (event) => onInteraction());
  document.addEventListener('keydown', (event) => onInteraction());

  num lastTime = 0;
  while (true) {
    num nowTime = await window.animationFrame;
    num deltaTime = nowTime - lastTime;
    lastTime = nowTime;
    mainctx.doFrame(deltaTime);
  }
}

MainCtx setupMainCtx() {
  CanvasElement canvas = new CanvasElement(width: 948, height: 533)
    ..style.position = 'absolute'
    ..style.left = '50%'
    ..style.top = '50%'
    ..style.transform = 'translate(-50%, -50%)'
    ..style.border = '1px solid black';
  late MainCtx mainctx;

  DivElement div = new DivElement()..append(canvas);
  document.body?.nodes.add(div);

  InputState inputs = new InputState();
  inputs.registerListeners(canvas);
  mainctx = new MainCtx(canvas, inputs);

  // addNumberInput("Speed",
  return mainctx;
}
