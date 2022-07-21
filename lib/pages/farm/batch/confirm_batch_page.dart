import 'dart:developer';

import 'package:epoultry/models/batch_model.dart';
import 'package:epoultry/services/batches_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../widgets/gradient_widget.dart';
import '../../../widgets/success_widget.dart';

class ConfirmBatchPage extends StatelessWidget {
  ConfirmBatchPage({Key? key, required this.newBatch}) : super(key: key);

  final Batches newBatch;
  BatchesService _batchesService = BatchesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: CustomColors.background,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(
              PhosphorIcons.arrowLeft,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: CustomSpacing.s2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Confirm this Batch",
                    style: TextStyle(fontSize: 3.h),
                  ),
                ),
                SizedBox(
                  height: 60.h,
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Batch Name",
                            style: TextStyle(
                                color: CustomColors.secondary, fontSize: 2.4.h),
                          ),
                          Text(
                            '${newBatch.name}',
                            style: TextStyle(fontSize: 2.1.h),
                          )
                        ],
                      ),
                      SizedBox(
                        height: CustomSpacing.s1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Type of Birds",
                            style: TextStyle(
                                color: CustomColors.secondary, fontSize: 2.4.h),
                          ),
                          Text(
                            '${newBatch.type}',
                            style: TextStyle(fontSize: 2.1.h),
                          )
                        ],
                      ),
                      SizedBox(
                        height: CustomSpacing.s1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Number of Birds",
                            style: TextStyle(
                                color: CustomColors.secondary, fontSize: 2.4.h),
                          ),
                          Text(
                            '${newBatch.quantity}',
                            style: TextStyle(fontSize: 2.1.h),
                          )
                        ],
                      ),
                      SizedBox(
                        height: CustomSpacing.s1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Age",
                            style: TextStyle(
                                color: CustomColors.secondary, fontSize: 2.4.h),
                          ),
                          Text(
                            '${newBatch.age + newBatch.units}',
                            style: TextStyle(fontSize: 2.1.h),
                          )
                        ],
                      ),
                      SizedBox(
                        height: CustomSpacing.s1,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Date",
                            style: TextStyle(
                                color: CustomColors.secondary, fontSize: 2.4.h),
                          ),
                          Text(
                            '${newBatch.date}',
                            style: TextStyle(fontSize: 2.1.h),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                GradientWidget(
                  child: ElevatedButton(
                      onPressed: () async {
                        await _batchesService.createItem(newBatch);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SuccessWidget(
                                      message:
                                          'You have successfully created a batch',
                                      route: 'dashboard',
                                    )));
                      },
                      child: Text('CONFIRM'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          onSurface: Colors.transparent,
                          shadowColor: Colors.transparent,
                          onPrimary: CustomColors.background,
                          fixedSize: Size(100.w, 6.h))),
                ),
              ],
            )));
  }
}
