import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../theme/colors.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  AppbarWidget({Key? key, @required this.drawerKey})
      : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  final drawerKey;
  @override
  final Size preferredSize;

  @override
  Widget build(BuildContext context) {
    final box = Hive.box('appData');
    final name = box.get('name');

    return AppBar(
      automaticallyImplyLeading: false,
      leadingWidth: 80,
      toolbarHeight: 8.h,
      backgroundColor: CustomColors.white,
      elevation: 0.5,
      leading: InkWell(
        onTap: () {
          drawerKey.currentState!.openDrawer();
        },
        child: CircleAvatar(
          radius: 10,
          backgroundColor: CustomColors.secondary,
          child: Text(
            name.substring(0, 1),
            style: TextStyle(fontSize: 4.h, color: CustomColors.background),
          ),
        ),
      ),
      actions: const [
        IconButton(
            onPressed: null,
            icon: Icon(
              PhosphorIcons.bell,
              color: CustomColors.secondary,
            ))
      ],
      title: Text(
        name,
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}
