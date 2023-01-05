import 'package:epoultry/controllers/farm_controller.dart';
import 'package:epoultry/pages/farm/e-extension/vaccination/vaccine_details.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/string_extensions.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../theme/colors.dart';

class VaccinationList extends StatelessWidget {
  VaccinationList({super.key});

  final controller = Get.find<FarmsController>();

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
        title: const Text(
          'Batch 1 Vaccination',
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
                  "PENDING",
                  style: TextStyle(
                      fontSize: 2.2.h, color: CustomColors.textPrimary),
                ),
              ],
            ),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            Card(
                elevation: 0,
                child: ListTile(
                    onTap: () {},
                    title: Text('RDV Vaccine'),
                    subtitle: Text("3rd December 2022"),
                    trailing: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text('Complete Vaccination',
                            style:
                                TextStyle(fontSize: 1.5.h, color: Colors.blue)),
                        const Icon(PhosphorIcons.arrowRight,
                            color: Colors.blue),
                      ],
                    ))),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "COMPLETE",
                  style: TextStyle(
                      fontSize: 2.2.h, color: CustomColors.textPrimary),
                ),
                InkWell(
                  onTap: () {},
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text('SEE ALL',
                          style: TextStyle(
                            fontSize: 2.2.h,
                          )),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            Card(
                elevation: 0,
                child: ListTile(
                    onTap: () {
                      Get.to(() => VaccineDetails());
                    },
                    title: Text('RDV Vaccine'),
                    subtitle: Text("3rd December 2022"),
                    trailing: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text('Complete',
                            style: TextStyle(
                                fontSize: 1.5.h, color: Colors.green)),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }
}
