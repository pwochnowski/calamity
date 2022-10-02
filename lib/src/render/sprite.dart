// TODO: Make this generic over both animations and images
import '../resources/image_resource.dart';
import '../math/vector2.dart';
import 'renderer.dart';

class ImageSprite {
  Vector2 pos;
  Vector2 clip;
  ImageResource resource;

  ImageSprite(this.pos, this.clip, this.resource);

  void render(Renderer r) {
    r.renderImage(pos, clip, resource);
  }
}