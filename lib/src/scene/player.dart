
import 'package:calamity/src/math/static.dart';
import 'package:calamity/src/resources/animation_resource.dart';
import 'package:calamity/src/resources/image_resource.dart';
import 'package:calamity/src/scene/game_arena.dart';
import 'package:calamity/src/scene/game_object.dart';

import '../constants.dart';
import '../inputs/input_state.dart';
import '../math/vector2.dart';
import '../render/renderer.dart';
import '../resources/resources.dart';

class Player extends GameObject {
  ImageResource? _playerImage;
  AnimationResource? _playerAnimation;
  // Effectively non-nullable
  late GameArena arena;

  // used for hitbox of player
  final num radius = Constants.PLAYER_RADIUS;

  double movementSpeed = 10.0;
  Vector2 pos;
  Vector2 imageBounds = new Vector2(50, 50);

  Player(this.pos);


  void move(PlayerInputState input) {
    double x = 0.0;
    double y = 0.0;
    if (input.keys.contains(PlayerKey.LEFT)) { x -= 1; }
    if (input.keys.contains(PlayerKey.RIGHT)) { x += 1; }
    if (input.keys.contains(PlayerKey.UP)) { y -= 1; }
    if (input.keys.contains(PlayerKey.DOWN)) { y += 1; }
    pos += new Vector2(x, y).normalized() * movementSpeed;
  }

  void update(PlayerInputState input, num deltaTime) {
    move(input);
  }

  int frame = 0;
  void render(Renderer r) {
    AnimationResource animation = getPlayerAnimation();
    if (StaticData.random.nextDouble() < 0.1) {
      frame = StaticData.random.nextInt(animation.frameCount);
    }
    animation.renderFrame(r.ctx, frame, pos, imageBounds);
  }

  ImageResource getPlayerImage() => _playerImage ??= Resources.GameResources.getResource('player');
  AnimationResource getPlayerAnimation() => _playerAnimation ??= Resources.GameResources.getResource('player_tilesheet');
}
