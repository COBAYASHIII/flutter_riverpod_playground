import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterValueNotifier extends ValueNotifier<int> {
  CounterValueNotifier() : super(0);

  void increment() {
    value = value + 1;
  }
}

class CounterStateNotifier extends StateNotifier<int> {
  CounterStateNotifier() : super(0);

  void increment() {
    state = state + 1;
  }
}


