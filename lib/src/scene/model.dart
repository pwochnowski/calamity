import 'package:calamity/src/resources/audio_resource.dart';
import 'package:calamity/src/scene/player.dart';

import '../inputs/input_state.dart';
import '../math/vector2.dart';
import '../render/renderer.dart';
import '../resources/resources.dart';
import 'game_arena.dart';
import 'gg_screen.dart';
import 'launch_screen.dart';

class Model {
  final GameArena arena;
  final GameOverScreen ggScreen;
  final LaunchScreen launchScreen;
  final num width;
  final num height;
  num volumeModifier = 1.0;

  Model(this.width, this.height)
      : launchScreen = new LaunchScreen(),
        arena = new GameArena(width, height),
        ggScreen = new GameOverScreen() {
    ggScreen.arena = arena;
  }

  void update(PlayerInputState input, num deltaTime) {
    if (launchScreen.stillOpen) {
      launchScreen.update(input, deltaTime);
      return;
    }
    // print("ARENA UPDATE: ${input.mouse?.event.button} ${arena.playing}");
    AudioResource music = Resources.GameResources.getResource(Resources.MUSIC);
    if (input.keys.contains(PlayerKey.MUTE)) {
      volumeModifier = 1.0 - volumeModifier;
    }
    if (arena.playing) {
      music.setVolume(1 * volumeModifier);
      // print("Areana update ${arena.hashCode}");
      arena.update(input, deltaTime);
    } else {
      music.setVolume(0.06 * volumeModifier);
      // FIXME: There are many places this line of code could belong, this is not one of them
      ggScreen.setScore(arena.lastScore);
      ggScreen.update(input);
    }
  }

  void render(Renderer r) {
    if (launchScreen.stillOpen) {
      launchScreen.render(r);
      return;
    }
    if (arena.playing) {
      arena.render(r);
    } else {
      ggScreen.render(r);
    }
  }

  void startAudioLoop() {
    AudioResource music = Resources.GameResources.getResource(Resources.MUSIC);
    music.setVolume(1 * volumeModifier);
    // the section that should be looped is 211.90528 - 318.57194 (seconds)
    music.audio.onTimeUpdate.listen((event) {
      if (music.audio.currentTime > 318.57194) {
        music.audio.currentTime =
            music.audio.currentTime - 318.57194 + 211.90528;
      }
    });
    music.play();
  }
}
