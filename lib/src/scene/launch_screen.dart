import 'package:calamity/src/constants.dart';
import 'package:calamity/src/inputs/input_state.dart';
import 'package:calamity/src/math/vector2.dart';
import 'package:calamity/src/render/renderer.dart';
import 'package:calamity/src/resources/resources.dart';

class LaunchScreen {
  static final Vector2 pos = size / 2;
  static final Vector2 size =
      new Vector2(Constants.CANVAS_WIDTH, Constants.CANVAS_HEIGHT);
  bool stillOpen = true;
  void render(Renderer r) {
    r.renderImage(
        pos, size, Resources.GameResources.getResource(Resources.COVER));
    r.renderText(
        "🔊 Press M to toggle sound", new Vector2(5, 15), Justification.LEFT);
    r.renderText("Song is 'The Race Around the World' by Waterflame",
        new Vector2(5, Constants.CANVAS_HEIGHT - 20), Justification.LEFT);
    r.renderText("https://www.youtube.com/user/waterflame89",
        new Vector2(5, Constants.CANVAS_HEIGHT - 5), Justification.LEFT);
    r.renderText(
        "Controls",
        new Vector2(Constants.CANVAS_WIDTH - 5, Constants.CANVAS_HEIGHT - 55),
        Justification.RIGHT);
    r.renderText(
        "WASD/Arrow Keys/Right Mouse Button to move",
        new Vector2(Constants.CANVAS_WIDTH - 5, Constants.CANVAS_HEIGHT - 35),
        Justification.RIGHT);
    r.renderText(
        "Space/Left Mouse Button to fire a birdseed pellet",
        new Vector2(Constants.CANVAS_WIDTH - 5, Constants.CANVAS_HEIGHT - 20),
        Justification.RIGHT);
    r.renderText(
        "E to dash",
        new Vector2(Constants.CANVAS_WIDTH - 5, Constants.CANVAS_HEIGHT - 5),
        Justification.RIGHT);
    r.ctx.setStrokeColorRgb(255, 0, 0);
    r.ctx.setFillColorRgb(255, 0, 0);
    r.renderText("Press any mouse button or space to play",
        new Vector2(Constants.CANVAS_WIDTH - 5, 100), Justification.RIGHT);
  }

  void update(PlayerInputState inputState, num deltaTime) {
    if (inputState.mouse.left ||
        inputState.mouse.right ||
        inputState.keys.contains(PlayerKey.SHOOT)) {
      stillOpen = false;
    }
  }
}
