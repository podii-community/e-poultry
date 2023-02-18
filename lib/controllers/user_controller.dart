import 'package:get/get.dart';

class UserController extends GetxController {
  final userName = "".obs;
  final phoneNumber = "".obs;
  final userRole = "".obs;
  final userId = "".obs;
  final vetNumber = "".obs;

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
}
