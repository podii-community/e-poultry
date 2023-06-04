import 'package:get/get.dart';

class DashboardController extends GetxController {

  /// Control the state of the tabs
  var selectedTabIndex = 0.obs;

  void onTabSelected({required int index}) => selectedTabIndex.value = index;
}