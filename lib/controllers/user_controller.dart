import 'package:get/get.dart';

class UserController extends GetxController {
  final userName = "".obs;
  final phoneNumber = "".obs;

  updateName(name) {
    userName(name);
  }

  updatePhone(phone) {
    phoneNumber(phone);
  }
}
