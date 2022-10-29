import 'dart:async';

import 'package:epoultry/pages/farm/batch/list_batches_page.dart';
import 'package:epoultry/pages/farm/dashboard/farm_dashboard_page.dart';
import 'package:epoultry/pages/farm/join-farm/join_farm_page.dart';
import 'package:epoultry/theme/colors.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';


class SuccessWidget extends StatefulWidget {
  const SuccessWidget({Key? key, required this.message, required this.route})
      : super(key: key);
  final String message;
  final String route;

  @override
  State<SuccessWidget> createState() => _SuccessWidgetState();
}

class _SuccessWidgetState extends State<SuccessWidget> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 1200), () {
      switch (widget.route) {
        case "login":
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FarmDashboardPage()),
          );
          break;
        case "register":
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const JoinFarmPage()),
          );
          break;

        case "dashboard":
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FarmDashboardPage()),
          );
          break;

        case "batches":
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ListBatchPage()),
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
           Icon(PhosphorIcons.checkCircle, color: CustomColors.green, size: 10.5.h,),
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
