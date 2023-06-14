import 'package:epoultry/core/presentation/components/custom_snackbar.dart';
import 'package:epoultry/core/presentation/controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/colors.dart';

void reactiveSnackbar({required UserController userController}) =>
    ever(userController.hasInternetObservable, (value) {
      if (value == true) {
        return Get.showSnackbar(customSnackbar(
            title: "Connected",
            message: "Internet connection established",
            titleColor: CustomColors.green,
            messageColor: CustomColors.white,
            icon: Icons.wifi,
            iconColor: CustomColors.green,
            backgroundColor: CustomColors.snackbarBackground));
      } else {
        return Get.showSnackbar(customSnackbar(
            title: "Disconnected",
            message: "Internet connection lost",
            titleColor: CustomColors.redLight,
            messageColor: CustomColors.white,
            icon: Icons.wifi_off,
            iconColor: CustomColors.redLight,
            backgroundColor: CustomColors.snackbarBackground));
      }
    });
