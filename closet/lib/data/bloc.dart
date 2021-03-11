import 'dart:async';

class Bloc {
  Set <String> saved = Set<String>();

  final _savedController = StreamController<Set<String>>();

  get savedStream => _savedController.stream;

  addToOrRemoveFromSavedList(String item) {
    if(saved.contains(item)) {
      saved.remove(item);
    } else {
      saved.add(item);
    }

    _savedController.sink.add(saved); // <= 변경된 데이터 보내주는 기능.
  }

  Stream<Set<String>>
  dispose() {
    _savedController.close();
  }
}

var bloc = Bloc();