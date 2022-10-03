/// flawed color representation to confirm to
/// ctx methods e.g. setStrokeColorRgb
class Color {
  static Color RED = Color.fromHex(0xFF0000);
  static Color GREEN = Color.fromHex(0x00FF00);
  static Color BLUE = Color.fromHex(0x0000FF);
  static Color YELLOW = Color.fromHex(0xFFFF00);
  static Color LIGHTER_YELLOW = Color.fromHex(0xFFFFAA);

  final int r;
  final int g;
  final int b;
  final num a;

  Color(this.r, this.g, this.b, this.a);

  Color withAlpha(num alpha) {
    return new Color(r, g, b, alpha);
  }

  /// returns a color with full opacity e.g. 0x006699
  static Color fromHex(int hex) {
    int b = hex & 0xFF;
    hex >>= 8;
    int g = hex & 0xFF;
    hex >>= 8;
    int r = hex & 0xFF;
    num aFloat = 1.0;
    return new Color(r, g, b, aFloat);
  }
}
