import 'package:epoultry/pages/extensions/extension_homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sizer/sizer.dart';

import '../../theme/colors.dart';
import '../../theme/spacing.dart';
import '../../widgets/gradient_widget.dart';

class ExtensionOfficerProfile extends StatelessWidget {
  ExtensionOfficerProfile({super.key});

  final lastName = TextEditingController();
  final firstName = TextEditingController();
  final location = TextEditingController();
  final idNumber = TextEditingController();
  final phoneNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 8.h,
        backgroundColor: CustomColors.white,
        elevation: 0.5,
        title: const Text(
          "Complete Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: CustomSpacing.s3,
              ),
              SizedBox(
                width: double.infinity,
                height: 185,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(),
                        boxShadow: const [
                          BoxShadow(
                              color:
                                  Color.fromRGBO(0, 0, 0, 0.05000000074505806),
                              offset: Offset(0, 17.549407958984375),
                              blurRadius: 17.549407958984375)
                        ],
                        color: const Color.fromRGBO(246, 251, 255, 1),
                        border: Border.all(
                          color: const Color.fromRGBO(56, 78, 183, 1),
                          width: 0.731225311756134,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/Vector.svg',
                              semanticsLabel: 'vector'),
                          const SizedBox(height: 8),
                          Text(
                            'Upload Profile Photo',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 2.2.h, color: CustomColors.secondary
                                // color: Color.fromRGBO(1, 33, 56, 0.6000000238418579),
                                // fontFamily: 'DM Sans',
                                // fontSize: 14,
                                // letterSpacing: 0,
                                // fontWeight: FontWeight.normal,
                                // height: 1.2535291399274553
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: firstName,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'First Name is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "First Name",
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
                keyboardType: TextInputType.text,
                controller: lastName,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Last Name is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Last Name",
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
                keyboardType: TextInputType.text,
                controller: idNumber,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'ID Number is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "ID Number",
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
                keyboardType: TextInputType.text,
                controller: phoneNumber,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Phone Number is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Phone Number",
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
                keyboardType: TextInputType.text,
                controller: location,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Location is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Location",
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
              GradientWidget(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ExtensionHomePage()));
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
                      'Update Profile',
                      style: TextStyle(
                        fontSize: 2.4.h,
                      ),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
