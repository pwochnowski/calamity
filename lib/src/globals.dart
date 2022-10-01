
// Future<Null> delayMillis(num millis);
Future<Null> delay(num millis) async => await Future.delayed(new Duration(milliseconds: millis.toInt()));
