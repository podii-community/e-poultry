import 'package:epoultry/theme/colors.dart';
import 'package:epoultry/widgets/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:string_extensions/string_extensions.dart';

import '../../../../data/models/batch_model.dart';
import '../../../../theme/spacing.dart';

class SawdustReceived extends StatefulWidget {
  const SawdustReceived(
      {Key? key, required this.batchDetails, required this.report})
      : super(key: key);

  final BatchModel batchDetails;
  final report;

  @override
  State<SawdustReceived> createState() => _SawdustReceivedState();
}

class _SawdustReceivedState extends State<SawdustReceived> {
  String sawdustReceived = "";
  final _formKey = GlobalKey<FormState>();
  final sawdustUsedAmount = TextEditingController();
  final sawdustReceivedAmount = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          toolbarHeight: 8.h,
          backgroundColor: CustomColors.white,
          elevation: 0.5,
          leading: IconButton(
            icon: const Icon(
              PhosphorIcons.arrowLeft,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            widget.batchDetails.name,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Sawdust",
                      style: TextStyle(fontSize: 3.h),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                    child: Card(
                      elevation: 0,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: CustomSpacing.s2,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: CustomSpacing.s2),
                              child: GridView.count(
                                crossAxisCount: 2,
                                crossAxisSpacing: CustomSpacing.s1,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Type of Birds",
                                        style: TextStyle(
                                            color: CustomColors.secondary,
                                            fontSize: 2.h),
                                      ),
                                      Text(
                                        (widget.batchDetails.type!.name)
                                            .capitalize!,
                                        style: TextStyle(
                                            color: CustomColors.secondary,
                                            fontSize: 2.8.h,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "No of Birds",
                                        style: TextStyle(
                                            color: CustomColors.secondary,
                                            fontSize: 2.h),
                                      ),
                                      Text(
                                        "${widget.batchDetails.birdCount}",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: CustomColors.secondary,
                                            fontSize: 2.8.h,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Update sawdust used?",
                        style: TextStyle(
                          fontSize: 2.2.h,
                        ),
                      ),
                      SizedBox(
                        height: CustomSpacing.s3,
                      ),
                      TextFormField(
                        controller: sawdustUsedAmount,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter amount';
                          }
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.3.w, color: CustomColors.secondary)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.3.w, color: CustomColors.secondary)),
                          labelText: "Sawdust used",
                          prefixText: 'Kgs',
                          labelStyle: TextStyle(
                              fontSize: 2.2.h, color: CustomColors.secondary),
                        ),
                      ),
                      const SizedBox(
                        height: CustomSpacing.s3,
                      ),
                      Text(
                        "Have you received sawdust today",
                        style: TextStyle(
                          fontSize: 2.2.h,
                        ),
                      ),
                      const SizedBox(
                        height: CustomSpacing.s1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 40.w,
                            child: ListTile(
                              title: const Text('Yes'),
                              leading: Radio<String>(
                                value: "yes",
                                groupValue: sawdustReceived,
                                onChanged: (value) {
                                  setState(() {
                                    sawdustReceived = value.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40.w,
                            child: ListTile(
                              title: const Text('No'),
                              leading: Radio<String>(
                                value: "no",
                                groupValue: sawdustReceived,
                                onChanged: (value) {
                                  setState(() {
                                    sawdustReceived = value.toString();
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),

                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  sawdustReceived == 'yes'
                      ? Form(
                          key: _formKey,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Update sawdust received?",
                                style: TextStyle(
                                  fontSize: 2.2.h,
                                ),
                              ),
                              const SizedBox(
                                height: CustomSpacing.s2,
                              ),
                              TextFormField(
                                controller: sawdustReceivedAmount,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter quantity';
                                  }
                                },
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.3.w,
                                          color: CustomColors.secondary)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.3.w,
                                          color: CustomColors.secondary)),
                                  labelStyle: TextStyle(
                                      fontSize: 2.2.h,
                                      color: CustomColors.secondary),
                                ),
                              ),
                              const SizedBox(
                                height: CustomSpacing.s3,
                              ),
                            ],
                          ),
                        )
                      : Container(),

                  // SizedBox(

                  GradientWidget(
                    child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            onSurface: Colors.transparent,
                            shadowColor: Colors.transparent,
                            onPrimary: CustomColors.background,
                            fixedSize: Size(100.w, 6.h)),
                        child: Text(
                          'UPDATE SAWDUST',
                          style: TextStyle(
                              fontSize: 4.w, fontWeight: FontWeight.w700),
                        )),
                  ),
                ],
              )),
        ));
  }
}
