import 'package:flutter/material.dart';
import 'package:get/get.dart';

GetSnackBar customSnackbar({
  required String title,
  required String message,
  required Color titleColor,
  required Color messageColor,
  required IconData icon,
  required Color iconColor,
  required Color backgroundColor,
}) =>
    GetSnackBar(
      titleText: Text(
        title,
        style: TextStyle(
            color: titleColor,
            fontFamily:
                Theme.of(Get.context!).textTheme.titleMedium?.fontFamily,
            fontSize: Theme.of(Get.context!).textTheme.titleMedium?.fontSize),
      ),
      messageText: Text(
        message,
        style: TextStyle(
            color: messageColor,
            fontFamily: Theme.of(Get.context!).textTheme.bodyMedium?.fontFamily,
            fontSize: Theme.of(Get.context!).textTheme.bodyMedium?.fontSize),
      ),
      backgroundColor: backgroundColor,
      icon: Icon(
        icon,
        color: iconColor,
      ),
      dismissDirection: DismissDirection.down,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(16),
      borderRadius: 16,
    );
