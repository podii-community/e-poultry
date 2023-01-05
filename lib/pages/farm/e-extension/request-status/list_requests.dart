import 'package:epoultry/pages/farm/e-extension/request-status/request_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../theme/colors.dart';
import '../../../../theme/spacing.dart';

class ListRequest extends StatelessWidget {
  const ListRequest({super.key});

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
            'Request Status',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
          child: ListView(
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => RequestDetails());
                },
                child: Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('TODAY'),
                        const SizedBox(
                          height: CustomSpacing.s1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Farm Visit Request',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 2.1.h),
                            ),
                            Text('4:10pm')
                          ],
                        ),
                        const SizedBox(
                          height: CustomSpacing.s1,
                        ),
                        const Text(
                            'Lorem ipsum dolor sit amet, consectetur adipiscing elit...'),
                        const SizedBox(
                          height: CustomSpacing.s2,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              '#PENDING',
                              style: TextStyle(color: Colors.yellow),
                            ),
                            Icon(PhosphorIcons.arrowRight)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Divider()
            ],
          ),
        ));
  }
}
