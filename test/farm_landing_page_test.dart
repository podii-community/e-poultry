import 'package:epoultry/pages/farm/farm_landing_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('', () {
    testWidgets('', (WidgetTester tester) async {
      await tester.pumpWidget(const FarmLandingPage());
      expect(find.byType(AssetImage), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
      expect(find.byType(OutlinedButton), findsOneWidget);
    });
  });
}
