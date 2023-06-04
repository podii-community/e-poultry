import 'package:epoultry/core/presentation/components/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('GradientWidget with ElevatedButton test',
      (WidgetTester tester) async {
    final formKey = GlobalKey<FormState>();
    var saveCalled = false;

    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: GradientWidget(
          child: ElevatedButton(
            onPressed: () {
              formKey.currentState?.save();
              saveCalled = true;
            },
            child: const Text('PROCEED'),
          ),
        ),
      ),
    ));

    final buttonFinder = find.text('PROCEED');
    expect(buttonFinder, findsOneWidget);

    await tester.tap(buttonFinder);
    await tester.pump();

    expect(saveCalled, true);
  });
}
