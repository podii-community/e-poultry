import 'package:epoultry/core/presentation/controllers/user_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../theme/colors.dart';

void reactiveSnackbar({required UserController userController}) =>
    ever(userController.hasInternetObservable, (value) {
      if (value == true) {
        return Get.showSnackbar(const GetSnackBar(
          titleText: Text(
            "Connected",
            style: TextStyle(
                color: CustomColors.green, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          message: "Internet connection established",
          backgroundColor: CustomColors.snackbarBackground,
          icon: Icon(
            Icons.wifi,
            color: CustomColors.green,
          ),
          dismissDirection: DismissDirection.down,
          duration: Duration(seconds: 3),
          margin: EdgeInsets.all(16),
          borderRadius: 16,
        ));
      } else {
        return Get.showSnackbar(const GetSnackBar(
          titleText: Text(
            "Disconnected",
            style: TextStyle(
                color: CustomColors.redLight, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          message: "Internet connection lost",
          backgroundColor: CustomColors.snackbarBackground,
          icon: Icon(
            Icons.wifi_off,
            color: CustomColors.redLight,
          ),
          dismissDirection: DismissDirection.down,
          margin: EdgeInsets.all(16),
          borderRadius: 16,
        ));
      }
    });
