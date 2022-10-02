import 'package:calamity/src/resources/resources.dart';
import 'dart:html';
class AudioResource implements Resource {
  final AudioElement audio;
  AudioResource(this.audio);

  void play() {
    audio.play();
  }

  /// sets the volume between 0 to 1
  void setVolume(num volume) {
    audio.volume = volume;
  }

  static Future<AudioResource> load(String resourcePath) async {
    AudioElement audio = new AudioElement(resourcePath);
    return new AudioResource(audio);
  }
}
