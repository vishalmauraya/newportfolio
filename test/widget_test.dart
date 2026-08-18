import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:untitled1/main.dart';

void main() {
  testWidgets('Portfolio loads smoke test', (WidgetTester tester) async {
    // Set test screen size to desktop web dimension
    tester.view.physicalSize = const Size(1280, 900);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const VishalPortfolioApp());
    await tester.pump();
    expect(find.text('Vishal Kumar'), findsWidgets);
  });
}
