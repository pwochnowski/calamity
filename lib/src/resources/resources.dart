import 'package:calamity/src/resources/image_resource.dart';

abstract class Resource {}

class Resources {
  final Map<String, Resource> _resources;

  Resources._(): this._resources = {};

  static Resources GameResources = Resources._();

  Resource? getResource(String name) {
    return _resources[name];
  }

  /// Monster function that loads all of the resources
  Future<Null> loadAll() async {
    _resources['player'] = await ImageResource.load('player.png');
  }
}