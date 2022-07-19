import 'package:epoultry/pages/landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LandingPage', () {
    testWidgets(
        'Homepage is displayed with chicken basket logo, an image,signup and login buttons',
        (WidgetTester tester) async {
      await tester.pumpWidget(const LandingPage());
      expect(find.byType(AssetImage), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
    });
  });
}
