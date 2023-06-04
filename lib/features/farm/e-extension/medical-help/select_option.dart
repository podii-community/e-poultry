import 'package:epoultry/features/farm/e-extension/medical-help/send_request.dart';
import 'package:epoultry/theme/colors.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

class SelectOption extends StatelessWidget {
  const SelectOption({super.key});

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
            'Get Medical help',
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
                Text(
                  "Select an option",
                  style: TextStyle(fontSize: 1.8.h),
                ),
                const SizedBox(
                  height: CustomSpacing.s2,
                ),
                ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      leading: const Icon(PhosphorIcons.phoneCall),
                      title: const Text("Call us on 0742088393"),
                      onTap: () {
                        // ignore: deprecated_member_use
                        launch('tel:+254742088393');
                      },
                    ),
                    const Divider(),
                    ListTile(
                      onTap: () {
                        Get.to(() => const GetMedicalHelp());
                      },
                      leading: const Icon(PhosphorIcons.clipboardText),
                      title: const Text("Send a request on app"),
                    ),
                  ],
                )
              ],
            )));
  }
}
