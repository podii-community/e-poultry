import 'package:get/get.dart';

class UserController extends GetxController {
  final userName = "".obs;

  updateName(name) {
    userName(name);
  }
}
