import 'package:epoultry/core/controllers/user_controller.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserController', () {
    late UserController controller;
    setUp(() {
      controller = UserController();
    });

    test('updateName', () {
      // Given
      var name = 'Me Two';

      // When
      controller.updateName(name);

      // Then
      expect(controller.userName.value, name);
    });

    test('updatePhone', () {
      // Given
      var phone = '0711800260';

      // When
      controller.updatePhone(phone);

      // Then
      expect(controller.phoneNumber.value, phone);
    });

    test('updateRole', () {
      // Given
      var role = 'admin';

      // When
      controller.updateRole(role);

      // Then
      expect(controller.userRole.value, role);
    });
  });
}
