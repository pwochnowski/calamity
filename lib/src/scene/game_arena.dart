import 'package:calamity/src/scene/player.dart';

import '../inputs/input_state.dart';
import '../math/vector2.dart';
import '../render/renderer.dart';
import 'bullet.dart';
import 'bullet_spawner.dart';

class GameArena {
  final num width;
  final num height;
  Player player;
  final BulletSpawner bulletSpawner;
  List<Bullet> bullets = [];
  GameArena(this.width, this.height)
      : player = new Player(new Vector2(50, 50)),
        bulletSpawner = new BulletSpawner(10) {
    player.setArena(this);
    bulletSpawner.setArena(this);
  }

  void update(PlayerInputState input) {
    player.update(input);
    bulletSpawner.update(input);
    for (Bullet bullet in bullets) {
      bullet.update(input);
    }
  }

  void render(Renderer r) {
    player.render(r);
    bulletSpawner.render(r);
    for (Bullet bullet in bullets) {
      bullet.render(r);
    }
  }
}
