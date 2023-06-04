import 'dart:async';

import 'package:epoultry/core/presentation/controllers/user_controller.dart';
import 'package:epoultry/features/farm/dashboard/presentation/screens/list_batches_page.dart';
import 'package:epoultry/features/farm/dashboard/presentation/farm_dashboard_page.dart';
import 'package:epoultry/features/farm/farm-managers/manage_farm_managers_page.dart';
import 'package:epoultry/features/farm/join-farm/join_farm_page.dart';
import 'package:epoultry/core/theme/colors.dart';
import 'package:epoultry/core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../controllers/farm_controller.dart';
import '../../../features/extensions/extension_homepage.dart';
import '../../../features/extensions/extension_officer_profile.dart';
import '../../../features/veterinary/vet_homepage.dart';
import '../../../features/veterinary/vet_profile.dart';

class SuccessWidget extends StatefulWidget {
  const SuccessWidget({
    Key? key,
    required this.message,
    required this.route,
  }) : super(key: key);
  final String message;
  final String route;

  @override
  State<SuccessWidget> createState() => _SuccessWidgetState();
}

class _SuccessWidgetState extends State<SuccessWidget> {
  Timer? _timer;
  final controller = Get.find<FarmsController>();
  final userController = Get.find<UserController>();

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1200), () {
      switch (widget.route) {
        case "farmer":
          Get.off(() => const FarmDashboardPage());

          break;
        case "farm_manager":
          Get.off(() => const FarmDashboardPage());

          break;
        case "vet":
          Get.off(() => const VeterinaryHomePage());
          break;
        case "veterinary":
          Get.off(() => const VetProfile());

          break;
        case "ext":
          Get.off(() => const ExtensionOfficerProfile());

          break;
        case "extension":
          Get.off(() => const ExtensionHomePage());

          break;
        case "register":
          Get.to(() => const JoinFarmPage());
          break;

        case "dashboard":
          Get.off(() => const FarmDashboardPage());

          break;
        case "isUnAssigned":
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => const JoinFarmPage(isUnAssigned: true)),
          );
          break;

        case "batches":
          Get.to(() => const ListBatchPage());
          break;

        case "manager":
          Navigator.of(context)
            ..pop()
            ..pushReplacement(
              MaterialPageRoute(
                  builder: (context) => const ManageFarmManagers()),
            );
          break;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            PhosphorIcons.checkCircle,
            color: CustomColors.green,
            size: 10.5.h,
          ),
          const SizedBox(
            height: CustomSpacing.s2,
          ),
          widget.message.isNotEmpty
              ? Text(
                  widget.message,
                  style: TextStyle(fontSize: 5.w),
                  textAlign: TextAlign.center,
                )
              : Container()
        ],
      ),
    ));
  }
}
