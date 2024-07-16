import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

@immutable
class StackItem {
  final String value;
  const StackItem({required this.value});

  StackItem copyWith({String? value}) {
    return StackItem(value: value ?? this.value);
  }
}

class StackItemsNotifier extends StateNotifier<List<StackItem>?> {
  StackItemsNotifier(List<StackItem> item) : super(null);
  void push(StackItem item) {
    state = [...?state, item];
  }

  void pop(String id) {
    state = state?.where((element) => element.value != id).toList();
  }

  void reset() {
    state = null;
  }
}

final stackProvider =
    StateNotifierProvider<StackItemsNotifier, List<StackItem>?>((ref) {
  return StackItemsNotifier([]);
});
