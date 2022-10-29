import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../data/models/batch_model.dart';
import '../../../../theme/colors.dart';

class MedicationReceived extends StatefulWidget {
  const MedicationReceived(
      {Key? key, required this.batchDetails, required this.report})
      : super(key: key);

  final BatchModel batchDetails;
  final report;

  @override
  State<MedicationReceived> createState() => _MedicationReceivedState();
}

class _MedicationReceivedState extends State<MedicationReceived> {
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
    );
  }
}
