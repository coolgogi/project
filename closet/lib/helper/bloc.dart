import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Bloc {
  Set <Card> selected = Set<Card>();

  final _selectedController = StreamController<Set<Card>>();

  get selectedStream => _selectedController.stream;

  addToOrRemoveFromSelectedList(Widget item) {
    if(selected.contains(item))
      selected.remove(item);
    else
      selected.add(item);

    _selectedController.sink.add(selected);
  }

  dispose() {
    _selectedController.close();
  }
}

var bloc = Bloc();

