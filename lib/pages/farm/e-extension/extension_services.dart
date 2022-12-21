import 'package:epoultry/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
            title: Text('Vaccination',
                style: TextStyle(
                    color: CustomColors.textPrimary, fontSize: 2.2.h)),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              PhosphorIcons.prescriptionBold,
              color: CustomColors.textPrimary,
              size: 3.h,
            ),
            title: Text('Get Medical Help',
                style: TextStyle(
                    color: CustomColors.textPrimary, fontSize: 2.2.h)),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              PhosphorIcons.clipboardBold,
              color: CustomColors.textPrimary,
              size: 3.h,
            ),
            title: Text('Request Farm Visit',
                style: TextStyle(
                    color: CustomColors.textPrimary, fontSize: 2.2.h)),
          ),
          Divider(),
          ListTile(
            leading: Icon(
              PhosphorIcons.presentationBold,
              color: CustomColors.textPrimary,
              size: 3.h,
            ),
            title: Text('Status of Request',
                style: TextStyle(
                    color: CustomColors.textPrimary, fontSize: 2.2.h)),
          ),
          Divider(),
        ],
      ),
    );
  }
}
