import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../theme/colors.dart';
import '../../theme/spacing.dart';
import '../../widgets/gradient_widget.dart';
import 'confirm_farm_info.dart';
import 'housing_inspection_summary.dart';

class HousingInspection extends StatefulWidget {
  const HousingInspection({super.key});

  @override
  State<HousingInspection> createState() => _HousingInspectionState();
}

class _HousingInspectionState extends State<HousingInspection> {
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
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: CustomSpacing.s2,
              ),
              Form(
                  // key: _formKey,
                  child: Column(
                children: [
                  TextFormField(
                    // controller: name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: "Bio Security",
                        labelStyle: TextStyle(
                            fontSize: 2.2.h, color: CustomColors.secondary),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary))),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  TextFormField(
                    // controller: name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: "Cob Webs",
                        labelStyle: TextStyle(
                            fontSize: 2.2.h, color: CustomColors.secondary),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary))),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  TextFormField(
                    // controller: name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: "Dust",
                        labelStyle: TextStyle(
                            fontSize: 2.2.h, color: CustomColors.secondary),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary))),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  TextFormField(
                    // controller: age,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: "Lighting",
                        labelStyle: TextStyle(
                            fontSize: 2.2.h, color: CustomColors.secondary),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary))),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  TextFormField(
                    // controller: name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: "Ventilation",
                        labelStyle: TextStyle(
                            fontSize: 2.2.h, color: CustomColors.secondary),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary))),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  TextFormField(
                    // controller: name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: "Repair and Maintainance",
                        labelStyle: TextStyle(
                            fontSize: 2.2.h, color: CustomColors.secondary),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary))),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  TextFormField(
                    // controller: name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: "Drinkers",
                        labelStyle: TextStyle(
                            fontSize: 2.2.h, color: CustomColors.secondary),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary))),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  TextFormField(
                    // controller: name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: "Feeders",
                        labelStyle: TextStyle(
                            fontSize: 2.2.h, color: CustomColors.secondary),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: 0.3.w, color: CustomColors.secondary))),
                  ),
                ],
              )),
              const SizedBox(
                height: CustomSpacing.s3,
              ),
              GradientWidget(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const ConfirmHousingInspection(),
                        ),
                      );
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
            ])));
  }
}
