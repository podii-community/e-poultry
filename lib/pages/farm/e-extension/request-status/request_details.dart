import 'dart:developer';

import 'package:epoultry/theme/colors.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class RequestDetails extends StatelessWidget {
  RequestDetails({super.key, this.request});

  final request;
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  @override
  Widget build(BuildContext context) {
    log("${this.request}");
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
            'Farm Visit Request',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: CustomSpacing.s2,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('STATUS OF REQUEST'),
                  const SizedBox(
                    height: CustomSpacing.s1,
                  ),
                  Text(
                    '${request["status"]}',
                    style: const TextStyle(color: Colors.yellow),
                  ),
                ],
              ),
              const SizedBox(
                height: CustomSpacing.s3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('DATE OF VISIT'),
                  SizedBox(
                    height: CustomSpacing.s1,
                  ),
                  Text(
                    formatter.format(formatter.parse(request['createdAt'])),
                  ),
                ],
              ),
              const SizedBox(
                height: CustomSpacing.s3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('PURPOSE OF VISIT'),
                  const SizedBox(
                    height: CustomSpacing.s1,
                  ),
                  Text(
                    '${request["farmVisit"] != null ? request["farmVisit"]["visitPurpose"] : "Medical Visit"}',
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
