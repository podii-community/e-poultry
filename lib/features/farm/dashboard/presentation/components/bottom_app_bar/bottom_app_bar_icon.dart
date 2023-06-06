import 'package:epoultry/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

Widget bottomAppBarIcon(
    {required String title,
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap}) {
  //  gradient for the icon and text
  const Gradient gradient =
      LinearGradient(colors: [CustomColors.primary, CustomColors.yellow]);

  return InkWell(
    borderRadius: BorderRadius.circular(16),
    onTap: onTap,
    child: Ink(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          isActive
              ? ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => gradient.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                  child: Icon(
                    icon,
                    color: CustomColors.secondary,
                  ),
                )
              : Icon(
                  icon,
                  color: CustomColors.secondary,
                ),
          const SizedBox(height: 8),
          isActive
              ? ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => gradient.createShader(
                      Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                  child: Text(
                    title,
                  ),
                )
              : Text(
                  title,
                )
        ],
      ),
    ),
  );
}
