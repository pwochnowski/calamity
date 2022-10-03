import 'package:calamity/src/resources/animation_resource.dart';
import 'package:calamity/src/resources/audio_resource.dart';
import 'package:calamity/src/resources/image_resource.dart';

import 'animation_frame.dart';
import 'animation_manifests.dart';

abstract class Resource {}

class Resources {
  static final String ENEMY = 'enemy';
  static final String PLAYER_ANIMATION = 'player_animation';
  static final String CHICK_ANIMATION = 'chick_animation';
  static final String CHICK_SCORE_ANIMATION = 'chick_score_animation';
  static final String BULLET_ANIMATION = 'bullet_animation';
  static final String SHOTGUN_ANIMATION = 'shotgun_animation';
  static final String BOULDER = 'boulder';
  static final String BACKGROUND = 'background';
  static final String GRAINS = 'grains';

  static final String MUSIC = 'music';
  final Map<String, Resource> _resources;
  late PlayerAnimationManifest playerAnimationManifest;
  late ChickAnimationManifest chickAnimationManifest;
  late BulletAnimationManifest bulletAnimationManifest;
  late ShotgunAnimationManifest shotgunAnimationManifest;
  late Animation chickScoreAnimation;

  Resources._() : this._resources = {} {
    playerAnimationManifest =
        new PlayerAnimationManifest(() => getResource(PLAYER_ANIMATION));
    chickAnimationManifest =
        new ChickAnimationManifest(() => getResource(CHICK_ANIMATION));
    bulletAnimationManifest =
        new BulletAnimationManifest(() => getResource(BULLET_ANIMATION));
    shotgunAnimationManifest =
        new ShotgunAnimationManifest(() => getResource(SHOTGUN_ANIMATION));
    chickScoreAnimation = new Animation(
        () => getResource(CHICK_SCORE_ANIMATION), [0, 1, 2, 3, 4, 5, 6, 7, 8]);
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
    _resources[PLAYER_ANIMATION] =
        await AnimationResource.load('player_animation.png', 100, 100, 44);
    _resources[CHICK_ANIMATION] =
        await AnimationResource.load('chick_animation.png', 20, 20, 15);
    _resources[CHICK_SCORE_ANIMATION] =
        await AnimationResource.load('chick_score_animation.png', 50, 50, 9);
    _resources[BULLET_ANIMATION] =
        await AnimationResource.load('bullet_animation.png', 50, 50, 4);
    _resources[SHOTGUN_ANIMATION] =
        await AnimationResource.load('shotgun_animation.png', 100, 100, 24);
    _resources[BOULDER] = await ImageResource.load('boulder.png');
    _resources[BACKGROUND] = await ImageResource.load('background.png');
    _resources[MUSIC] = await AudioResource.load('Repeat_mixdown 3_01.mp3');
    _resources[GRAINS] = await ImageResource.load('grains.png');
  }
}
