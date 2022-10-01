import 'dart:math';

import 'package:calamity/src/inputs/input_state.dart';
import 'package:calamity/src/math/static.dart';
import 'package:calamity/src/scene/game_arena.dart';

import '../math/vector2.dart';
import '../render/renderer.dart';
import 'bullet.dart';

class BulletSpawner {
  GameArena? _enclosingArena;
  int numBullets = 10;
  static final Vector2 bulletHitbox = new Vector2(50, 50);

  void setArena(GameArena arena) => _enclosingArena = arena;

  BulletSpawner(this.numBullets);

  Bullet spawnBulletAtEdge() {
    Vector2 position = new Vector2(_enclosingArena!.width / 2, _enclosingArena!.height / 2);
    num angle = 2 * pi * StaticData.random.nextDouble();
    Vector2 vel = new Vector2(sin(angle), cos(angle)) * 15.0;
    Bullet bullet = new Bullet(position, vel, bulletHitbox);
    bullet.setArena(_enclosingArena!);
    return bullet;
  }

  void update(PlayerInputState input) {
    GameArena arena = _enclosingArena!;
    arena.bullets.retainWhere((Bullet bullet) => bullet.isInBounds());
    int numToSpawn = max(0, numBullets - arena.bullets.length);
    for (int i = 0; i < numToSpawn; ++i) {
      arena.bullets.add(spawnBulletAtEdge());
    }
  }

  void render(Renderer r) {}
}