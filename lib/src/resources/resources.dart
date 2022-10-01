import 'package:calamity/src/resources/animation_resource.dart';
import 'package:calamity/src/resources/image_resource.dart';

abstract class Resource {}

class Resources {
  static final String PLAYER = 'player';
  static final String PLAYER_ANIMATION = 'player_animation';
  static final String BOULDER = 'boulder';
  final Map<String, Resource> _resources;

  Resources._(): this._resources = {};

  static Resources GameResources = Resources._();

  T getResource<T extends Resource>(String name) {
    assert(_resources.containsKey(name));
    return _resources[name] as T;
  }

  /// Monster function that loads all of the resources
  Future<Null> loadAll() async {
    _resources[PLAYER] = await ImageResource.load('player.png');
    _resources[PLAYER_ANIMATION] = await AnimationResource.load('player_animation.png', 80, 110, 24);
    _resources[BOULDER] = await ImageResource.load('boulder.png');
  }
}
