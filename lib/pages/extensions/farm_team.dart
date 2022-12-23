import 'package:epoultry/pages/extensions/store_compound_summary.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../theme/colors.dart';
import '../../theme/spacing.dart';
import '../../widgets/gradient_widget.dart';
import 'farm_team_summary.dart';

class FarmTeam extends StatefulWidget {
  const FarmTeam({super.key});

  @override
  State<FarmTeam> createState() => _FarmTeamState();
}

class _FarmTeamState extends State<FarmTeam> {
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
                      "Farm Team",
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
                            // controller: name,
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
                          TextFormField(
                            // controller: name,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                labelText: "Uniforms/Overalls",
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
                            // controller: name,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                                labelText: "Gumboots",
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ConfirmFarmTeam(),
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
                  ])),
        ));
  }
}
