import 'dart:ui';

import 'package:epoultry/pages/extensions/farm_visit_report.dart';
import 'package:epoultry/widgets/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../theme/colors.dart';
import '../../theme/spacing.dart';

class FarmVisits extends StatefulWidget {
  const FarmVisits({super.key});

  @override
  State<FarmVisits> createState() => _FarmVisitsState();
}

class _FarmVisitsState extends State<FarmVisits> {
  bool dealStatus = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              dealStatus
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'FARM VISIT REQUESTS',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color:
                                  Color.fromRGBO(1, 33, 56, 0.6000000238418579),
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              letterSpacing: 0.15000000596046448,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'Odongo odongo would like you to visit Teriq farm in Vihiga, sublocation, ward on Monday, 17th October 2022.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(1, 33, 56, 1),
                              fontFamily: 'DM Sans',
                              fontSize: 16,
                              letterSpacing: -0.23999999463558197,
                              fontWeight: FontWeight.normal,
                              height: 1.375),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Today 4:00pm',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color:
                                  Color.fromRGBO(1, 33, 56, 0.3799999952316284),
                              fontFamily: 'Open Sans',
                              fontSize: 10,
                              letterSpacing: 0,
                              fontWeight: FontWeight.normal,
                              height: 1.6),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: TextButton.icon(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 5, sigmaY: 5),
                                        child: SimpleDialog(
                                          // title: const Text('Confirm'),
                                          children: [
                                            Container(
                                              height: 10,
                                              alignment:
                                                  FractionalOffset.topRight,
                                              child: IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: const Icon(Icons.clear),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text("#ACCEPT"),
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Text(
                                                  "You will be visiting Teriq farm in Vihiga, sublocation, ward on Monday, 17th October 2022."),
                                            ),
                                            SimpleDialogOption(
                                              onPressed: () {
                                                // Confirm action
                                                Navigator.of(context).pop();
                                              },
                                              child: GradientWidget(
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        dealStatus = false;
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        foregroundColor:
                                                            CustomColors
                                                                .background,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        disabledForegroundColor:
                                                            Colors.transparent
                                                                .withOpacity(
                                                                    0.38),
                                                        disabledBackgroundColor:
                                                            Colors.transparent
                                                                .withOpacity(
                                                                    0.12),
                                                        shadowColor:
                                                            Colors.transparent,
                                                        fixedSize:
                                                            Size(100.w, 6.h)),
                                                    child: Text(
                                                      'CONFIRM',
                                                      style: TextStyle(
                                                        fontSize: 2.4.h,
                                                      ),
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.check),
                                label: const Text('Accept'),
                                style: TextButton.styleFrom(
                                  side: const BorderSide(
                                      width: 3.0, color: Colors.green),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: TextButton.icon(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 5, sigmaY: 5),
                                        child: SimpleDialog(
                                          // title: const Text('Confirm'),
                                          children: [
                                            Container(
                                              height: 10,
                                              alignment:
                                                  FractionalOffset.topRight,
                                              child: IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: const Icon(Icons.clear),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                minLines: 6,
                                                maxLines: 8,
                                                // controller: firstName,
                                                keyboardType:
                                                    TextInputType.text,
                                                // validator: (String? value) {
                                                //   if (value!.isEmpty) {
                                                //     return 'First Name is required';
                                                //   }
                                                //   return null;
                                                // },
                                                decoration: InputDecoration(
                                                    labelText:
                                                        "Reason for Decline",
                                                    labelStyle: TextStyle(
                                                        fontSize: 2.2.h,
                                                        color: CustomColors
                                                            .secondary),
                                                    border: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 0.3.w,
                                                            color: CustomColors
                                                                .secondary)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            width: 0.3.w,
                                                            color: CustomColors
                                                                .secondary))),
                                              ),
                                            ),
                                            SimpleDialogOption(
                                              onPressed: () {
                                                // Confirm action
                                                Navigator.of(context).pop();
                                              },
                                              child: GradientWidget(
                                                child: ElevatedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    style: ElevatedButton.styleFrom(
                                                        foregroundColor:
                                                            CustomColors
                                                                .background,
                                                        backgroundColor:
                                                            Colors.transparent,
                                                        disabledForegroundColor:
                                                            Colors.transparent
                                                                .withOpacity(
                                                                    0.38),
                                                        disabledBackgroundColor:
                                                            Colors.transparent
                                                                .withOpacity(
                                                                    0.12),
                                                        shadowColor:
                                                            Colors.transparent,
                                                        fixedSize:
                                                            Size(100.w, 6.h)),
                                                    child: Text(
                                                      'CONFIRM',
                                                      style: TextStyle(
                                                        fontSize: 2.4.h,
                                                      ),
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.call),
                                label: const Text('Call'),
                                style: TextButton.styleFrom(
                                  side: const BorderSide(
                                      width: 3.0, color: Colors.amber),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          'FARM VISIT REQUESTS',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color:
                                  Color.fromRGBO(1, 33, 56, 0.6000000238418579),
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              letterSpacing: 0.15000000596046448,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          '#ACCEPTED',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color:
                                  Color.fromRGBO(1, 33, 56, 0.6000000238418579),
                              fontFamily: 'Roboto',
                              fontSize: 12,
                              letterSpacing: 0.15000000596046448,
                              fontWeight: FontWeight.normal,
                              height: 1),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'You will be visiting Teriq farm in Vihiga, sublocation, ward on Monday, 17th October 2022.',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: Color.fromRGBO(1, 33, 56, 1),
                              fontFamily: 'DM Sans',
                              fontSize: 16,
                              letterSpacing: -0.23999999463558197,
                              fontWeight: FontWeight.normal,
                              height: 1.375),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Expanded(
                              child: TextButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const FarmVisitReport(),
                                    ),
                                  );
                                },
                                icon: const Icon(
                                  PhosphorIcons.plusCircle,
                                  size: 32.0,
                                ),
                                label: const Text('Add a Farm Visit Report'),
                                style: TextButton.styleFrom(
                                  side: const BorderSide(
                                      width: 3.0, color: Colors.black26),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
              const SizedBox(height: 40),
              const Text(
                'PREVIOUS FARM VISITS',
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Color.fromRGBO(1, 33, 56, 0.6000000238418579),
                    fontFamily: 'Roboto',
                    fontSize: 12,
                    letterSpacing: 0.15000000596046448,
                    fontWeight: FontWeight.normal,
                    height: 1),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                height: 131,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  color: Color.fromRGBO(246, 251, 255, 1),
                ),
                child: const Center(
                  child: Text(
                    'All your previous reports will appear here',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Color.fromRGBO(1, 33, 56, 0.3799999952316284),
                        fontFamily: 'DM Sans',
                        fontSize: 16,
                        letterSpacing: -0.23999999463558197,
                        fontWeight: FontWeight.normal,
                        height: 1.375),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
