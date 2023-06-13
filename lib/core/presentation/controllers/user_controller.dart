import 'dart:async';

import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class UserController extends GetxController {
  final userName = "".obs;
  final phoneNumber = "".obs;
  final userRole = "".obs;
  final userId = "".obs;
  final vetNumber = "".obs;
  final loc = "".obs;
  final profileImage = "".obs;

  //  Observe Internet connectivity
  late StreamSubscription internetSubscription;
  final hasInternet = true.obs;

  updateName(name) {
    userName(name);
  }

  updatePhone(phone) {
    phoneNumber(phone);
  }

  updateRole(role) {
    userRole(role);
  }

  updateVetNumber(number) {
    vetNumber(number);
  }

  updateId(id) {
    userId(id);
  }

  updateLoc(location) {
    loc(location);
  }

  updateProfile(profile) {
    profileImage(profile);
  }

  void observeInternetConnection() {
    internetSubscription =
        InternetConnectionChecker().onStatusChange.listen((status) {
      hasInternet.value = status == InternetConnectionStatus.connected;
    });
  }
}
