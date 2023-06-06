import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget mainBottomAppBar({required List<Widget> tabs}) => BottomAppBar(
  height: 80,
  elevation: 0,
  shape: const CircularNotchedRectangle(),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: tabs,
  ),
);