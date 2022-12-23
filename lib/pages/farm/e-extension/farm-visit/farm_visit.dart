import 'dart:developer';

import 'package:epoultry/theme/spacing.dart';
import 'package:epoultry/widgets/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../theme/colors.dart';

class RequestFarmVisit extends StatelessWidget {
  RequestFarmVisit({super.key});

  final date = TextEditingController();
  final purpose = TextEditingController();
  bool agree = false;

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
            'Request Farm Visit',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
        body: SingleChildScrollView(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: CustomSpacing.s3,
                    ),
                    Text(
                      "Select the date for the visit",
                      style: TextStyle(fontSize: 2.1.h),
                    ),
                    const SizedBox(
                      height: CustomSpacing.s2,
                    ),
                    TextFormField(
                      controller: date,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Date is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Date",
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
                      height: CustomSpacing.s2,
                    ),
                    TextFormField(
                      controller: purpose,
                      maxLines: 5,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Purpose is required';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: "Purpose of the visit",
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
                      height: CustomSpacing.s2,
                    ),
                    CheckboxListTile(
                      title: Text(
                          "I understand that this service may accrue a charge that will be agreed upon by both the officer and I"),
                      value: agree,
                      onChanged: (newValue) {
                        log("${newValue}");
                      },
                      controlAffinity: ListTileControlAffinity
                          .leading, //  <-- leading Checkbox
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    GradientWidget(
                      child: ElevatedButton(
                        onPressed: () {},
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
                          'REQUEST',
                          style: TextStyle(
                            fontSize: 1.8.h,
                          ),
                        ),
                      ),
                    ),
                  ],
                ))));
  }
}
