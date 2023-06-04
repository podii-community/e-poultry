import 'package:epoultry/theme/colors.dart';
import 'package:flutter/material.dart';

class LoadingSpinner extends Center {
  const LoadingSpinner({Key? key = defaultKey})
      : super(
            key: key,
            child: const CircularProgressIndicator(
              color: CustomColors.primary,
            ));

  static const Key defaultKey = Key('spinkit');
}
