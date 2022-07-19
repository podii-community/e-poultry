import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../theme/colors.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  AppbarWidget({Key? key})
      : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 80,
      leading: CircleAvatar(
        radius: 55,
        child: Text(
          "O",
          style: TextStyle(fontSize: 4.h, color: CustomColors.background),
        ),
        backgroundColor: CustomColors.primary,
      ),
      title: Text(
        "Odongo's Farm",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: CustomColors.background,
      elevation: 0.5,
    );
  }
}
