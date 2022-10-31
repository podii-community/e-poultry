import 'package:get/get.dart';

class UserController extends GetxController {
  final userName = "".obs;
  final phoneNumber = "".obs;
  final userRole = "".obs;

  updateName(name) {
    userName(name);
  }

  updatePhone(phone) {
    phoneNumber(phone);
  }

  updateRole(role) {
    userRole(role);
  }
}
