import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:string_extensions/string_extensions.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/widgets/gradient_widget.dart';
import '../../../core/controllers/farm_controller.dart';
import '../store_compound/store_compound.dart';

class ConfirmHousingInspection extends StatelessWidget {
  ConfirmHousingInspection({Key? key, this.report}) : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final report;
  final controller = Get.find<FarmsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Housing Ispection',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: CustomColors.background,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              PhosphorIcons.arrowLeft,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Summary",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s2,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: (controller
                                .farmVisitReport["data"]!['housingInspection']
                            as Map)
                        .keys
                        .map((key) => Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      (key as String).toTitleCase!,
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 2.3.h),
                                    ),
                                    Text(
                                      "${((controller.farmVisitReport["data"]!['housingInspection'] as Map)[key].toString())}  ",
                                      style: TextStyle(
                                          fontSize: 1.8.h, color: Colors.black),
                                    ),
                                  ],
                                ),
                                const Divider(),
                              ],
                            ))
                        .toList(),
                  ),
                  GradientWidget(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StoreAndCompound(),
                            ),
                          );
                          // _confirmBatchPressed(context, runMutation);
                        },
                        style: ElevatedButton.styleFrom(
                            foregroundColor: CustomColors.background,
                            backgroundColor: Colors.transparent,
                            disabledForegroundColor:
                                Colors.transparent.withOpacity(0.38),
                            disabledBackgroundColor:
                                Colors.transparent.withOpacity(0.12),
                            shadowColor: Colors.transparent,
                            fixedSize: Size(100.w, 6.h)),
                        child: const Text('CONFIRM')),
                  )
                ],
              ),
            )));
  }
}
