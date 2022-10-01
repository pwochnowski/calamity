import 'dart:html';

import 'package:calamity/src/resources/resources.dart';
import 'package:js/js.dart';

@JS('console.log')
external void consoleLog(Object object);

class ImageResource implements Resource {
  ImageElement bitmap;

  ImageResource(this.bitmap);

  static Future<ImageResource> load(String resourcePath) async {
    ImageElement image = new ImageElement(src: resourcePath);
    await image.decode();
    return new ImageResource(image);
  }
}