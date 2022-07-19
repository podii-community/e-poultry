import 'package:epoultry/pages/farm/join_farm_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pinput/pinput.dart';

void main() {
  group('JoinFarmPage', () {
    testWidgets("Join Farm page should have otp input and button",
        (WidgetTester tester) async {
      await tester.pumpWidget(const JoinFarmPage());
      expect(find.byType(Pinput), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(2));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
