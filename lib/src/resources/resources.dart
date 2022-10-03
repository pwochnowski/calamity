import 'package:calamity/src/resources/animation_resource.dart';
import 'package:calamity/src/resources/audio_resource.dart';
import 'package:calamity/src/resources/image_resource.dart';

import 'animation_frame.dart';
import 'animation_manifests.dart';

abstract class Resource {}

class Resources {
  static final String PLAYER_ANIMATION = 'player_animation';
  static final String ENEMY_ANIMATION = 'enemy_animation';
  static final String CHICK_ANIMATION = 'chick_animation';
  static final String CHICK_SCORE_ANIMATION = 'chick_score_animation';
  static final String BULLET_ANIMATION = 'bullet_animation';
  static final String SHOTGUN_ANIMATION = 'shotgun_animation';
  static final String BOULDER = 'boulder';
  static final String BACKGROUND = 'background';
  static final String GRAINS = 'grains';
  static final String COVER = 'cover';
  static final String GAME_OVER = 'game_over';

  static final String MUSIC = 'music';
  final Map<String, Resource> _resources;
  late PlayerAnimationManifest playerAnimationManifest;
  late EnemyAnimationManifest enemyAnimationManifest;
  late ChickAnimationManifest chickAnimationManifest;
  late BulletAnimationManifest bulletAnimationManifest;
  late ShotgunAnimationManifest shotgunAnimationManifest;
  late Animation chickScoreAnimation;

  Resources._() : this._resources = {} {
    playerAnimationManifest =
        new PlayerAnimationManifest(() => getResource(PLAYER_ANIMATION));
    enemyAnimationManifest =
        new EnemyAnimationManifest(() => getResource(ENEMY_ANIMATION));
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
    Map<String, Future<Resource>> _promises = {};
    // TODO: Maybe request all of these in parallel? Would be trivial, would just require us to
    // await them all simultaneously
    _promises[ENEMY_ANIMATION] =
        AnimationResource.load('enemy_animation.png', 250, 250, 40);
    _promises[PLAYER_ANIMATION] =
        AnimationResource.load('player_animation.png', 100, 100, 44);
    _promises[CHICK_ANIMATION] =
        AnimationResource.load('chick_animation.png', 20, 20, 15);
    _promises[CHICK_SCORE_ANIMATION] =
        AnimationResource.load('chick_score_animation.png', 50, 50, 9);
    _promises[BULLET_ANIMATION] =
        AnimationResource.load('bullet_animation.png', 50, 50, 4);
    _promises[SHOTGUN_ANIMATION] =
        AnimationResource.load('shotgun_animation.png', 100, 100, 24);
    _promises[BOULDER] = ImageResource.load('boulder.png');
    _promises[BACKGROUND] = ImageResource.load('background.png');
    _promises[MUSIC] = AudioResource.load('Repeat_mixdown 3_01.mp3');
    _promises[GRAINS] = ImageResource.load('grains.png');
    _promises[COVER] = ImageResource.load('cover.png');
    _promises[GAME_OVER] = ImageResource.load('game_over.png');

    for (String key in _promises.keys) {
      _resources[key] = await _promises[key]!;
    }
  }
}
