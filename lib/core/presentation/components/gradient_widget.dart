import 'package:epoultry/theme/colors.dart';
import 'package:flutter/material.dart';

class GradientWidget extends StatelessWidget {
  const GradientWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: CustomColors.primaryGradient,
        borderRadius: BorderRadius.circular(5),
      ),
      child: child,
    );
  }
}
