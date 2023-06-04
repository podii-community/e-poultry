import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../core/presentation/controllers/farm_controller.dart';
import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../core/presentation/components/gradient_widget.dart';
import 'store_compound_summary.dart';

class StoreAndCompound extends StatefulWidget {
  const StoreAndCompound({super.key});

  @override
  State<StoreAndCompound> createState() => _StoreAndCompoundState();
}

class _StoreAndCompoundState extends State<StoreAndCompound> {
  final controller = Get.find<FarmsController>();
  final landscape = TextEditingController();
  final security = TextEditingController();
  final tankCleanliness = TextEditingController();
  final cleanliness = TextEditingController();
  final arrangement = TextEditingController();
  final stockTake = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Store & Compound',
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
                    const Text(
                      "Store",
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
                            controller: stockTake,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                labelText: "Stock Take",
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
                            controller: arrangement,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                labelText: "Arrangement",
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
                            controller: cleanliness,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                labelText: "Cleaniliness",
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
                    const Text(
                      "Compound",
                      style: TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: CustomSpacing.s3,
                    ),
                    TextFormField(
                      controller: landscape,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: "Landscape",
                          labelStyle: TextStyle(
                              fontSize: 2.2.h, color: CustomColors.secondary),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.3.w, color: CustomColors.secondary)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.3.w,
                                  color: CustomColors.secondary))),
                    ),
                    const SizedBox(
                      height: CustomSpacing.s3,
                    ),
                    TextFormField(
                      controller: security,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          labelText: "Security",
                          labelStyle: TextStyle(
                              fontSize: 2.2.h, color: CustomColors.secondary),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.3.w, color: CustomColors.secondary)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.3.w,
                                  color: CustomColors.secondary))),
                    ),
                    const SizedBox(
                      height: CustomSpacing.s3,
                    ),
                    TextFormField(
                      controller: tankCleanliness,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                          labelText: "Tank Cleaniliness",
                          labelStyle: TextStyle(
                              fontSize: 2.2.h, color: CustomColors.secondary),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.3.w, color: CustomColors.secondary)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.3.w,
                                  color: CustomColors.secondary))),
                    ),
                    const SizedBox(
                      height: CustomSpacing.s3,
                    ),
                    GradientWidget(
                      child: ElevatedButton(
                          onPressed: () {
                            (controller.farmVisitReport["data"]!["compound"]
                                as Map)["landscape"](landscape.text);

                            (controller.farmVisitReport["data"]!["compound"]
                                as Map)["security"](security.text);

                            (controller.farmVisitReport["data"]!["compound"]
                                    as Map)["tankCleanliness"](
                                tankCleanliness.text);

                            (controller.farmVisitReport["data"]!["store"]
                                as Map)["cleanliness"](cleanliness.text);

                            (controller.farmVisitReport["data"]!["store"]
                                as Map)["arrangement"](arrangement.text);

                            (controller.farmVisitReport["data"]!["store"]
                                as Map)["stockTake"](stockTake.text);
                            Get.to(() => ConfirmStoreCompound());
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
