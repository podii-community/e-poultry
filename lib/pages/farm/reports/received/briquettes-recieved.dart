import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:string_extensions/string_extensions.dart';

import '../../../../data/models/batch_model.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/spacing.dart';
import '../../../../widgets/gradient_widget.dart';

class BriquettesReceived extends StatefulWidget {
  const BriquettesReceived(
      {Key? key, required this.batchDetails, required this.report})
      : super(key: key);

  final BatchModel batchDetails;
  final report;

  @override
  State<BriquettesReceived> createState() => _BriquettesReceivedState();
}

class _BriquettesReceivedState extends State<BriquettesReceived> {
  String briquettesReceived = "";
  final _formKey = GlobalKey<FormState>();
  final briquettesUsedAmount = TextEditingController();
  final briquettesReceivedAmount = TextEditingController();
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
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Briquettes",
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Update briquettes used?",
                        style: TextStyle(
                          fontSize: 2.2.h,
                        ),
                      ),
                      const SizedBox(
                        height: CustomSpacing.s3,
                      ),
                      TextFormField(
                        controller: briquettesUsedAmount,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter amount';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.3.w, color: CustomColors.secondary)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: 0.3.w, color: CustomColors.secondary)),
                          labelText: "Briquettes used",
                          prefixText: 'Kgs',
                          labelStyle: TextStyle(
                              fontSize: 2.2.h, color: CustomColors.secondary),
                        ),
                      ),
                      const SizedBox(
                        height: CustomSpacing.s3,
                      ),
                      Text(
                        "Have you received briquettes today",
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
                                groupValue: briquettesReceived,
                                onChanged: (value) {
                                  setState(() {
                                    briquettesReceived = value.toString();
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
                                groupValue: briquettesReceived,
                                onChanged: (value) {
                                  setState(() {
                                    briquettesReceived = value.toString();
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
                  briquettesReceived == 'yes'
                      ? Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Update briquettes received?",
                                style: TextStyle(
                                  fontSize: 2.2.h,
                                ),
                              ),
                              const SizedBox(
                                height: CustomSpacing.s2,
                              ),
                              TextFormField(
                                controller: briquettesReceivedAmount,
                                keyboardType: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter quantity';
                                  }
                                  return null;
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
                          'UPDATE BRIQUETTES',
                          style: TextStyle(
                              fontSize: 4.w, fontWeight: FontWeight.w700),
                        )),
                  ),
                ],
              )),
        ));
  }
}
