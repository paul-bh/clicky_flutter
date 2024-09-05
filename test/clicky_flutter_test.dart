import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:clicky_flutter/clicky_flutter.dart';

void main() {
  test('create a button with TouchEffectWrapper class', () {
    final button = Clicky(
      child: Text('Click me'),
    );
    expect(button, isNotNull);
  });
}
