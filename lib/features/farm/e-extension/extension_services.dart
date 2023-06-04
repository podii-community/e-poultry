import 'package:epoultry/features/farm/e-extension/medical-help/select_option.dart';
import 'package:epoultry/features/farm/e-extension/request-status/list_requests.dart';
import 'package:epoultry/features/farm/e-extension/farm-visit/farm_visit.dart';
import 'package:epoultry/features/farm/e-extension/vaccination/select_batch.dart';
import 'package:epoultry/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

class ExtensionService extends StatelessWidget {
  const ExtensionService({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ListTile(
            leading: Icon(
              PhosphorIcons.syringeBold,
              color: CustomColors.textPrimary,
              size: 3.h,
            ),
            onTap: () {
              Get.to(() => const SelectBatch());
            },
            title: Text('Vaccination',
                style: TextStyle(
                    color: CustomColors.textPrimary, fontSize: 2.2.h)),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Get.to(() => const SelectOption());
            },
            leading: Icon(
              PhosphorIcons.prescriptionBold,
              color: CustomColors.textPrimary,
              size: 3.h,
            ),
            title: Text('Get Medical Help',
                style: TextStyle(
                    color: CustomColors.textPrimary, fontSize: 2.2.h)),
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              PhosphorIcons.clipboardBold,
              color: CustomColors.textPrimary,
              size: 3.h,
            ),
            onTap: () {
              Get.to(() => const RequestFarmVisit());
            },
            title: Text('Request Farm Visit',
                style: TextStyle(
                    color: CustomColors.textPrimary, fontSize: 2.2.h)),
          ),
          const Divider(),
          ListTile(
            leading: Icon(
              PhosphorIcons.presentationBold,
              color: CustomColors.textPrimary,
              size: 3.h,
            ),
            title: Text('Status of Request',
                style: TextStyle(
                    color: CustomColors.textPrimary, fontSize: 2.2.h)),
            onTap: () {
              Get.to(() => const ListRequest());
            },
          ),
          const Divider(),
        ],
      ),
    );
  }
}
