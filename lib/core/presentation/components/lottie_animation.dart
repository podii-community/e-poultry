import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation extends StatefulWidget {
  final String lottie;

  const LottieAnimation({Key? key, required this.lottie}) : super(key: key);

  @override
  State<LottieAnimation> createState() => _LottieAnimationState();
}

class _LottieAnimationState extends State<LottieAnimation>
    with TickerProviderStateMixin {
  //  to customize our animation
  late AnimationController _lottieController;

  @override
  void initState() {
    super.initState();

    _lottieController =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
  }

  @override
  void dispose() {
    //  finish our lottie animation
    _lottieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(widget.lottie,
        animate: true,
        reverse: false,
        controller: _lottieController, onLoaded: (composition) {
      _lottieController.duration = composition.duration;
      _lottieController.forward();
    });
  }
}
