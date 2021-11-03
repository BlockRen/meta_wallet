// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta_wallet/main.dart';
import 'package:meta_wallet/route/page_router.dart';

void main() {
  testWidgets('Test page_router', (WidgetTester tester) async {
    PageRouter router = PageRouter();
    expect(router.isSimpleRouteName("transaction"), true);
    expect(router.isSimpleRouteName("transaction page"), true);
    expect(router.isSimpleRouteName("transaction_page"), true);
    expect(router.isSimpleRouteName("meta://transaction"), false);
    expect(router.isSimpleRouteName("transaction?key=value"), false);
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // // Build our app and trigger a frame.
    // await tester.pumpWidget(const MetaApp());
    //
    // // Verify that our counter starts at 0.
    // expect(find.text('0'), findsOneWidget);
    // expect(find.text('1'), findsNothing);
    //
    // // Tap the '+' icon and trigger a frame.
    // await tester.tap(find.byIcon(Icons.add));
    // await tester.pump();
    //
    // // Verify that our counter has incremented.
    // expect(find.text('0'), findsNothing);
    // expect(find.text('1'), findsOneWidget);
  });
}
