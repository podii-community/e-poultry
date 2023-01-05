import 'package:epoultry/theme/colors.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class RequestDetails extends StatelessWidget {
  const RequestDetails({super.key});

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
            'Farm Visit Request',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: CustomSpacing.s2,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('STATUS OF REQUEST'),
                  SizedBox(
                    height: CustomSpacing.s1,
                  ),
                  Text(
                    'Pending',
                    style: TextStyle(color: Colors.yellow),
                  ),
                ],
              ),
              SizedBox(
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
                    '1ST June 2022',
                  ),
                ],
              ),
              SizedBox(
                height: CustomSpacing.s3,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('PURPOSE OF VISIT'),
                  SizedBox(
                    height: CustomSpacing.s1,
                  ),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit...',
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
