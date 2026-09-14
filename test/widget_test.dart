import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:move_app/main.dart';
import 'package:move_app/core/theme/app_theme.dart';

void main() {
  testWidgets('App initializes with dark theme smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.byType(MyApp), findsOneWidget);
    expect(AppTheme.darkTheme.brightness, equals(Brightness.dark));
  });
}
