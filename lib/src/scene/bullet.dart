import '../math/vector2.dart';

class Bullet {
  Vector2 pos;
  Vector2 orientation;
  Vector2 velocity;
  // AABB hitboxes
  Vector2 hitBox;

  Bullet(this.pos, this.orientation, this.velocity, this.hitBox);
}