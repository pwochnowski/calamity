import 'package:calamity/src/resources/animation_resource.dart';
import 'package:calamity/src/resources/image_resource.dart';

abstract class Resource {}

class Resources {
  final Map<String, Resource> _resources;

  Resources._(): this._resources = {};

  static Resources GameResources = Resources._();

  T getResource<T extends Resource>(String name) {
    assert(_resources.containsKey(name));
    return _resources[name] as T;
  }

  /// Monster function that loads all of the resources
  Future<Null> loadAll() async {
    _resources['player'] = await ImageResource.load('player.png');
    _resources['player_tilesheet'] = await AnimationResource.load('player_tilesheet.png', 80, 110, 24);
  }
}
