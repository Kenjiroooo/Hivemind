import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hivemind/main.dart';

void main() {
  testWidgets('HivemindApp smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: HivemindApp()));

    // Pump frames to allow splash delay and animations to complete
    await tester.pump(const Duration(milliseconds: 100));
    await tester.pumpAndSettle(const Duration(seconds: 2));

    // Verify that our app renders.
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
