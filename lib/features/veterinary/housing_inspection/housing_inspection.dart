import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../core/presentation/controllers/farm_controller.dart';
import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../core/presentation/components/gradient_widget.dart';
import 'housing_inspection_summary.dart';

class HousingInspection extends StatefulWidget {
  const HousingInspection({super.key});

  @override
  State<HousingInspection> createState() => _HousingInspectionState();
}

class _HousingInspectionState extends State<HousingInspection> {
  final controller = Get.find<FarmsController>();
  final bioSecurity = TextEditingController();
  final cobwebs = TextEditingController();
  final drinkers = TextEditingController();
  final dust = TextEditingController();
  final feeders = TextEditingController();
  final lighting = TextEditingController();
  final repairAndMaintainance = TextEditingController();
  final ventilation = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Housing Information',
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
            onPressed: () {},
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: CustomSpacing.s2,
                    ),
                    Form(
                        // key: _formKey,
                        child: Column(
                      children: [
                        TextFormField(
                          controller: bioSecurity,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              labelText: "Bio Security",
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
                          controller: cobwebs,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              labelText: "Cob Webs",
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
                          controller: dust,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              labelText: "Dust",
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
                          controller: lighting,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              labelText: "Lighting",
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
                          controller: ventilation,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              labelText: "Ventilation",
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
                          controller: repairAndMaintainance,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              labelText: "Repair and Maintainance",
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
                          controller: drinkers,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              labelText: "Drinkers",
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
                          controller: feeders,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              labelText: "Feeders",
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
                      ],
                    )),
                    const SizedBox(
                      height: CustomSpacing.s3,
                    ),
                    GradientWidget(
                      child: ElevatedButton(
                          onPressed: () {
                            // _farmInfoFormKey.currentState?.save();
                            (controller.farmVisitReport["data"]![
                                    "housingInspection"]
                                as Map)["bioSecurity"](bioSecurity.text);
                            (controller.farmVisitReport["data"]![
                                    "housingInspection"]
                                as Map)["cobwebs"](cobwebs.text);

                            (controller.farmVisitReport["data"]![
                                    "housingInspection"]
                                as Map)["drinkers"](drinkers.text);

                            (controller.farmVisitReport["data"]![
                                "housingInspection"] as Map)["dust"](dust.text);

                            (controller.farmVisitReport["data"]![
                                    "housingInspection"]
                                as Map)["feeders"](feeders.text);

                            (controller.farmVisitReport["data"]![
                                    "housingInspection"]
                                as Map)["lighting"](lighting.text);

                            (controller.farmVisitReport["data"]![
                                        "housingInspection"]
                                    as Map)["repairAndMaintainance"](
                                repairAndMaintainance.text);
                            (controller.farmVisitReport["data"]![
                                    "housingInspection"]
                                as Map)["ventilation"](ventilation.text);

                            // if (_farmInfoFormKey.currentState?.validate()) {
                            Get.to(() => ConfirmHousingInspection());
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) =>
                            //         const ConfirmHousingInspection(),
                            //   ),
                            // );
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
