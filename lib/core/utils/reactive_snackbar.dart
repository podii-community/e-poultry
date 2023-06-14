import 'package:epoultry/core/presentation/controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/colors.dart';

void reactiveSnackbar({required UserController userController}) =>
    ever(userController.hasInternetObservable, (value) {
      if (value == true) {
        return Get.showSnackbar(GetSnackBar(
          titleText: Text(
            "Connected",
            style: TextStyle(
                color: CustomColors.green,
                fontFamily:
                    Theme.of(Get.context!).textTheme.titleMedium?.fontFamily,
                fontSize:
                    Theme.of(Get.context!).textTheme.titleMedium?.fontSize),
          ),
          messageText: Text(
            "Internet connection established",
            style: TextStyle(
                color: CustomColors.white,
                fontFamily:
                Theme.of(Get.context!).textTheme.bodyMedium?.fontFamily,
                fontSize:
                Theme.of(Get.context!).textTheme.bodyMedium?.fontSize),
          ),
          backgroundColor: CustomColors.snackbarBackground,
          icon: const Icon(
            Icons.wifi,
            color: CustomColors.green,
          ),
          dismissDirection: DismissDirection.down,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(16),
          borderRadius: 16,
        ));
      } else {
        return Get.showSnackbar(GetSnackBar(
          titleText: Text("Disconnected",
              style: TextStyle(
                  color: CustomColors.redLight,
                  fontFamily:
                      Theme.of(Get.context!).textTheme.titleMedium?.fontFamily,
                  fontSize:
                      Theme.of(Get.context!).textTheme.titleMedium?.fontSize)),
          messageText: Text(
            "Internet connection lost",
            style: TextStyle(
                color: CustomColors.white,
                fontFamily:
                    Theme.of(Get.context!).textTheme.bodyMedium?.fontFamily,
                fontSize:
                    Theme.of(Get.context!).textTheme.bodyMedium?.fontSize),
          ),
          backgroundColor: CustomColors.snackbarBackground,
          icon: const Icon(
            Icons.wifi_off,
            color: CustomColors.redLight,
          ),
          dismissDirection: DismissDirection.down,
          duration: const Duration(seconds: 3),
          margin: const EdgeInsets.all(16),
          borderRadius: 16,
        ));
      }
    });
