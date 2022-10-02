import 'dart:math';

typedef T GetterT<T>();

class StaticData {
  static final Random random = new Random();

  // Prevent construction
  StaticData._();
}
