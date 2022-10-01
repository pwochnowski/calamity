import 'package:calamity/src/scene/player.dart';

import '../constants.dart';
import '../inputs/input_state.dart';
import '../math/vector2.dart';
import '../render/renderer.dart';
import 'bullet.dart';
import 'bullet_spawner.dart';

class GameArena {
  final num width;
  final num height;
  final Player player;

  final BulletSpawner bulletSpawner;
  List<Bullet> bullets = [];

  GameArena(this.width, this.height)
      : player = new Player(new Vector2(50, 50)),
        bulletSpawner = new BulletSpawner(Constants.NUM_BULLETS) {

    player.arena = this;
    bulletSpawner.arena = this;
  }

  void update(PlayerInputState input) {
    // print("Update arena $playing");
    player.update(input);
    bulletSpawner.update(input);

    for (Bullet bullet in bullets) {
      bullet.update(input);

      if (bullet.collidesWithPlayer()) {
        killPlayer();
        break;
      }
    }
  }

  void render(Renderer r) {
    player.render(r);
    bulletSpawner.render(r);
    for (Bullet bullet in bullets) {
      bullet.render(r);
    }
  }

  // read by model
  bool playing = true;

  void killPlayer() {
    playing = false;
    bullets.clear();
    print("Game over");
  }
}
