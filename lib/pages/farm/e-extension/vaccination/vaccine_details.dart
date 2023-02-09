import 'package:epoultry/theme/colors.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class VaccineDetails extends StatelessWidget {
  VaccineDetails({super.key, this.vaccine});

  final vaccine;

  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 8.h,
        backgroundColor: CustomColors.white,
        elevation: 0.5,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            PhosphorIcons.arrowLeft,
            color: Colors.black,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(
          '${vaccine['vaccinationSchedule']['vaccineName']}',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: CustomSpacing.s1,
            ),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${vaccine['vaccinationSchedule']['vaccineName']}",
                  style: TextStyle(
                      fontSize: 2.2.h, color: CustomColors.textPrimary),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "DUE ${formatter.format(formatter.parse(vaccine['dateScheduled']))}",
                  style: TextStyle(
                      fontSize: 1.7.h, color: CustomColors.textPrimary),
                ),
              ],
            ),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            Card(elevation: 0, child: Image.asset('assets/chicken.png')),
            Text("${vaccine['vaccinationSchedule']["description"]}"),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
          ],
        ),
      ),
    );
  }
}
