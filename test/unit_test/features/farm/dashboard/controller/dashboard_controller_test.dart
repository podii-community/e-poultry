import 'package:epoultry/features/farm/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

void main() {

  late DashboardController dashboardController;

  setUpAll(() => Get.put(DashboardController()));
  
  setUp(() {
    dashboardController = Get.find();
  });
  
  group('bottom navigation tab index', () {

    test('intial tab index must be 0', () {
      //  Given
      int currentIndex = 0;
      //  When
      currentIndex = dashboardController.selectedTabIndex.value;
      //  Then
      expect(currentIndex, 0);
    });
    
    test('index should be updated on tab change', () {
      //  Given
      int selectedTabIndex = dashboardController.selectedTabIndex.value;
      //  When
      dashboardController.onTabSelected(index: 2);
      //  Then
      expect(dashboardController.selectedTabIndex.value, 2);
    });

  });
}