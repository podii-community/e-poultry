import 'package:epoultry/pages/otp_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pinput/pinput.dart';

void main() {
  group('OtpPage', () {
    testWidgets('Otp Page has otp input and button',
        (WidgetTester tester) async {
      await tester.pumpWidget(OtpPage());
      expect(find.byType(Pinput), findsOneWidget);
      expect(find.byType(Text), findsNWidgets(3));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
