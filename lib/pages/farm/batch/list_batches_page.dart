import 'dart:developer';

import 'package:epoultry/data/data_export.dart';
import 'package:epoultry/pages/farm/batch/create_batch_page.dart';
import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/farm_controller.dart';
import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/gradient_widget.dart';
import '../../../widgets/loading_spinner.dart';

class ListBatchPage extends StatefulWidget {
  const ListBatchPage({Key? key}) : super(key: key);

  @override
  State<ListBatchPage> createState() => _ListBatchPageState();
}

class _ListBatchPageState extends State<ListBatchPage> {
  final FarmsController controller = Get.put(FarmsController());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: CustomSpacing.s2,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Manage Batches",
              style: TextStyle(fontSize: 3.h),
            ),
          ),
          const SizedBox(
            height: CustomSpacing.s1,
          ),
          GradientWidget(
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateBatchPage()),
                );
              },
              leading: const Icon(
                PhosphorIcons.plusCircleFill,
                color: CustomColors.background,
              ),
              title: Text(
                "Add a new batch",
                style: TextStyle(fontSize: 2.3.h),
              ),
              tileColor: Colors.transparent,
              textColor: CustomColors.background,
            ),
          ),
          const SizedBox(
            height: CustomSpacing.s2,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "My Batches",
              style: TextStyle(fontSize: 2.2.h),
            ),
          ),
          const SizedBox(
            height: CustomSpacing.s1,
          ),
          Obx(() => controller.batchesList.isEmpty
              ? const Center(
                  child: Text("No Batch"),
                )
              : Container(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: controller.batchesList.length,
                      itemBuilder: (context, position) {
                        return Card(
                          elevation: 0.2,
                          child: ListTile(
                            title: Text(
                                "${controller.batchesList[position]["name"]}"),
                          ),
                        );
                      }),
                )),
        ],
      ),
    );
  }
}
