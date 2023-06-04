import 'package:epoultry/core/data/data_export.dart';
import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({Key? key, required this.error}) : super(key: key);

  final ErrorModel error;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        error.error,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
