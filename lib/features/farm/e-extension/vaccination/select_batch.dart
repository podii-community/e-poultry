import 'package:epoultry/core/presentation/controllers/farm_controller.dart';
import 'package:epoultry/features/farm/e-extension/vaccination/vaccination_list.dart';
import 'package:epoultry/core/theme/colors.dart';
import 'package:epoultry/core/theme/spacing.dart';
import 'package:epoultry/core/presentation/components/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class SelectBatch extends StatefulWidget {
  const SelectBatch({super.key});

  @override
  State<SelectBatch> createState() => _SelectBatchState();
}

class _SelectBatchState extends State<SelectBatch> {
  final controller = Get.find<FarmsController>();

  final selectedBatch = TextEditingController();

  @override
  void initState() {
    selectedBatch.text = controller.batchesList.first['id'];
    super.initState();
  }

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
          'Vaccination',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: CustomSpacing.s2,
            ),
            Text(
              "Select the batch you want to vaccinate",
              style: TextStyle(fontSize: 2.2.h),
            ),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            const SizedBox(
              height: CustomSpacing.s1,
            ),
            DropdownButtonFormField<dynamic>(
              // Initial Value
              key: UniqueKey(),
              value: selectedBatch.text,
              isExpanded: true,
              elevation: 0,
              decoration: InputDecoration(
                  hintText: "Select batch",
                  labelStyle:
                      TextStyle(fontSize: 2.2.h, color: CustomColors.secondary),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.3.w, color: CustomColors.secondary)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.3.w, color: CustomColors.secondary))),

              onChanged: (val) {
                setState(() {
                  selectedBatch.text = val;
                });
              },
              items: controller.batchesList.map((batch) {
                return DropdownMenuItem<dynamic>(
                  value: batch['id'],
                  child: Text(batch['name']),
                );
              }).toList(),
            ),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            GradientWidget(
              child: ElevatedButton(
                  onPressed: () {
                    Get.to(() => VaccinationList(
                          batchId: selectedBatch.text,
                        ));
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
                  child: Text(
                    'PROCEED',
                    style: TextStyle(
                      fontSize: 1.8.h,
                    ),
                  )),
            ),
            const SizedBox(
              height: CustomSpacing.s1,
            ),
          ],
        ),
      ),
    );
  }
}
