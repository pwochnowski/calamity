import 'dart:math';

import 'package:calamity/src/scene/system.dart';

import '../constants.dart';
import '../inputs/input_state.dart';
import '../math/static.dart';
import '../math/vector2.dart';
import '../render/renderer.dart';
import 'enemy.dart';
import 'feeder.dart';
import 'game_arena.dart';

class FeederSpawner extends System {
  late final GameArena arena;
  int numFeeders;

  FeederSpawner(this.numFeeders);

  Feeder _spawnFeederAtRandomLocation() {
    Random r = StaticData.random;
    num centerX = (r.nextDouble() * (arena.width - 200)) + 100;
    num centerY = (r.nextDouble() * (arena.height - 200)) + 100;
    num width = 50;
    num height = 50;
    return new Feeder(
        new Vector2(centerX, centerY), new Vector2(width, height));
  }

  @override
  void reset() {}

  @override
  void update(PlayerInputState input, num deltaTime) {
    if (!arena.playing) {
      return;
    }
    arena.feeders.retainWhere((Feeder f) => f.hasRemainingSeeds());
    int numToSpawn = max(0, numFeeders - arena.feeders.length);
    for (int i = 0; i < numToSpawn; ++i) {
      arena.feeders.add(_spawnFeederAtRandomLocation());
    }
  }

  @override
  void render(Renderer r) {}
}
