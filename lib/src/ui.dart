
import 'dart:html';

typedef void Setter<T>(T);
typedef T Getter<T>();

DivElement Div(Object content) {
  return new DivElement()
    ..nodes = listify(content);
}

Iterable<Node> listify(Object? stuff) {
  if (stuff == null) {
    return [];
  } else if (stuff is Iterable<Object?>) {
    return stuff.where((o) => o != null).map(_node);
  } else {
    return [_node(stuff)];
  }
}

Node _node(Object? o) {
  if (o is Node) {
    return o;
  } else if (o is String) {
    return new Text(o);
  } else if (o is num) {
    print("WARN: Do not directly render numbers, convert them appropriately");
    return new Text('$o');
  } else {
    print("WARNING: Not usable: $o ${o.runtimeType}");
    return new Text(o.toString());
//    assert(false);
//    return null;
  }
}

InputElementBase IntInput(String title, Getter<num> getter, Function setter) {
  NumberInputElement elem = new NumberInputElement();
  elem.title = title;

  // elem.value = getter().toStringAsFixed(2);

  elem.onInput.listen((Event event) {
    setter(elem.value);
  });

  elem.onFocus.listen((event) {
    elem.value = getter().toStringAsFixed(3);
  });
  elem.onSelect.listen((event) {
    elem.value = getter().toStringAsFixed(3);
  });
  return elem;
}