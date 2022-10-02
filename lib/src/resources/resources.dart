import 'package:calamity/src/resources/animation_resource.dart';
import 'package:calamity/src/resources/audio_resource.dart';
import 'package:calamity/src/resources/image_resource.dart';

import 'animation_manifests.dart';

abstract class Resource {}

class Resources {
  static final String ENEMY = 'enemy';
  static final String PLAYER_ANIMATION = 'player_animation';
  static final String BOULDER = 'boulder';
  static final String BACKGROUND = 'background';

  static final String MUSIC = 'music';
  final Map<String, Resource> _resources;
  late PlayerAnimationManifest playerAnimationManifest;

  Resources._(): this._resources = {} {
    playerAnimationManifest = new PlayerAnimationManifest(() => getResource(PLAYER_ANIMATION));
  }

  static Resources GameResources = Resources._();

  T getResource<T extends Resource>(String name) {
    assert(_resources.containsKey(name));
    return _resources[name] as T;
  }

  /// Monster function that loads all of the resources
  Future<Null> loadAll() async {
    // TODO: Maybe request all of these in parallel? Would be trivial, would just require us to
    // await them all simultaneously
    _resources[ENEMY] = await ImageResource.load('enemy.png');
    _resources[PLAYER_ANIMATION] = await AnimationResource.load('player_animation.png', 100, 100, 53);
    _resources[BOULDER] = await ImageResource.load('boulder.png');
    _resources[BACKGROUND] = await ImageResource.load('background.png');
    _resources[MUSIC] = await AudioResource.load('Repeat_mixdown 3_01.mp3');
  }
}
