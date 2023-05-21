import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../core/controllers/farm_controller.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/widgets/gradient_widget.dart';
import 'general_observation_summary.dart';

class GeneralObservations extends StatefulWidget {
  const GeneralObservations({super.key});

  @override
  State<GeneralObservations> createState() => _GeneralObservationsState();
}

class _GeneralObservationsState extends State<GeneralObservations> {
  final controller = Get.find<FarmsController>();
  final recommendations = TextEditingController();
  final generalObservation = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Back',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: CustomColors.background,
          // centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              PhosphorIcons.arrowLeft,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "General Observations",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: CustomSpacing.s2,
                    ),
                    Form(
                      // key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: generalObservation,
                            keyboardType: TextInputType.name,
                            minLines: 7,
                            maxLines: 8,
                            decoration: InputDecoration(
                                labelText: "General Observations",
                                labelStyle: TextStyle(
                                    fontSize: 2.2.h,
                                    color: CustomColors.secondary),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3.w,
                                        color: CustomColors.secondary)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3.w,
                                        color: CustomColors.secondary))),
                          ),
                          const SizedBox(
                            height: CustomSpacing.s3,
                          ),
                          TextFormField(
                            minLines: 7,
                            maxLines: 8,
                            controller: recommendations,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                labelText: "Recommendations",
                                labelStyle: TextStyle(
                                    fontSize: 2.2.h,
                                    color: CustomColors.secondary),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3.w,
                                        color: CustomColors.secondary)),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 0.3.w,
                                        color: CustomColors.secondary))),
                          ),
                          const SizedBox(
                            height: CustomSpacing.s3,
                          ),
                        ],
                      ),
                    ),
                    GradientWidget(
                      child: ElevatedButton(
                          onPressed: () {
                            controller.farmVisitReport["data"]![
                                "generalObservation"] = generalObservation.text;
                            controller.farmVisitReport["data"]![
                                "recommendations"] = recommendations.text;
                            Get.to(() => ConfirmGeneralObseravtions());
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
                          child: const Text('PROCEED')),
                    ),
                  ])),
        ));
  }
}
