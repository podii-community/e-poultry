import 'package:epoultry/pages/extensions/store_compound.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../widgets/gradient_widget.dart';

class ConfirmHousingInspection extends StatelessWidget {
  const ConfirmHousingInspection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Housing Ispection',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: CustomColors.background,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              PhosphorIcons.arrowLeft,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "Summary",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s2,
                  ),
                  GradientWidget(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const StoreAndCompound(),
                            ),
                          );
                          // _confirmBatchPressed(context, runMutation);
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
                        child: const Text('CONFIRM')),
                  )
                ],
              ),
            )));
  }
}
