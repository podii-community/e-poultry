import 'dart:async';
import 'dart:developer';

import 'package:epoultry/pages/farm/batch/list_batches_page.dart';
import 'package:epoultry/pages/farm/dashboard/farm_dashboard_page.dart';
import 'package:epoultry/pages/farm/farm-managers/manage-farm-managers_page.dart';
import 'package:epoultry/pages/farm/join-farm/join_farm_page.dart';
import 'package:epoultry/theme/colors.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../controllers/farm_controller.dart';

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
  final FarmsController controller =
      Get.put(FarmsController(), permanent: true);

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1200), () {
      switch (widget.route) {
        case "login":
          Get.off(() => FarmDashboardPage());

          break;
        case "register":
          Get.to(() => JoinFarmPage());
          break;

        case "dashboard":
          Get.off(() => FarmDashboardPage());

          break;
        case "isUnAssigned":
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
                builder: (context) => const JoinFarmPage(isUnAssigned: true)),
          );
          break;

        case "batches":
          Get.to(() => ListBatchPage());
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
