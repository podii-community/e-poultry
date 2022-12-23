import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../theme/colors.dart';
import '../../theme/spacing.dart';
import '../../widgets/gradient_widget.dart';
import 'confirm_farm_info.dart';

class FarmVisitReport extends StatefulWidget {
  const FarmVisitReport({super.key});

  @override
  State<FarmVisitReport> createState() => _FarmVisitReportState();
}

class _FarmVisitReportState extends State<FarmVisitReport> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Text(
            'Farm Information',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Farm Name:',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(1, 33, 56, 0.6000000238418579),
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        letterSpacing: 0.15000000596046448,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                  Text(
                    'Odongo\'s farm',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(1, 33, 56, 0.6000000238418579),
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        letterSpacing: 0.15000000596046448,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                ],
              ),
              const SizedBox(
                height: CustomSpacing.s2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Farm Location:',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(1, 33, 56, 0.6000000238418579),
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        letterSpacing: 0.15000000596046448,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                  Text(
                    'Vihiga, sub, ward',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(1, 33, 56, 0.6000000238418579),
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        letterSpacing: 0.15000000596046448,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                ],
              ),
              const SizedBox(
                height: CustomSpacing.s2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    'Date of Visit:',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(1, 33, 56, 0.6000000238418579),
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        letterSpacing: 0.15000000596046448,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                  Text(
                    '17/10/2022',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(1, 33, 56, 0.6000000238418579),
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        letterSpacing: 0.15000000596046448,
                        fontWeight: FontWeight.normal,
                        height: 1),
                  ),
                ],
              ),
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
                        labelText: "Farm Officer Contact",
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
                        labelText: "Farm Assistant Contact",
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
                        labelText: "Breed",
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
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          // controller: age,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Age",
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
                      ),
                      const SizedBox(
                        width: CustomSpacing.s3,
                      ),
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          // Initial Value
                          key: UniqueKey(),
                          // value: ageType,
                          isExpanded: true,
                          elevation: 0,
                          decoration: InputDecoration(
                              hintText: "--select--",
                              labelText: "Days/Weeks/Months",
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

                          onChanged: (val) {
                            setState(() {
                              // ageType = val;
                            });
                          },
                          items: const [],
                          // items: AgeTypes.values.map((AgeTypes ageType) {
                          //   return DropdownMenuItem<AgeTypes>(
                          //     value: ageType,
                          //     child: Text(ageType.name.toString()),
                          //   );
                          // }).toList(),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  TextFormField(
                    // controller: name,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        labelText: "Number of Birds Delivered",
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
                        labelText: "Number of Birds Remaining",
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
                          builder: (context) => const ConfirmFarmInformation(),
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
