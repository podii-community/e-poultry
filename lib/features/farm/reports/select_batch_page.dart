import 'package:epoultry/core/data/data_export.dart';
import 'package:epoultry/features/farm/reports/number_birds_page.dart';
import 'package:epoultry/features/farm/reports/store/feeds_store.dart';
import 'package:epoultry/core/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../core/controllers/farm_controller.dart';
import '../../../core/theme/colors.dart';
import '../dashboard/presentation/components/batch_page/create_batch_page.dart';

class SelectBatchPage extends StatefulWidget {
  const SelectBatchPage({Key? key}) : super(key: key);
  final bool isSelected = false;
  @override
  State<SelectBatchPage> createState() => _SelectBatchPageState();
}

class _SelectBatchPageState extends State<SelectBatchPage> {
  final List<bool> selected = List.generate(5, (i) => false);
  BatchModel? selectedBatch;

  final bool isSelected = false;

  final controller = Get.find<FarmsController>();

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
          'Select Batch',
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
              "Select the batch",
              style: TextStyle(fontSize: 3.h),
            ),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            const SizedBox(
              height: CustomSpacing.s1,
            ),
            TextField(
              onChanged: (value) {
                controller.filterBatches(value);
                setState(() {});
              },
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.symmetric(vertical: 5.w),
                  prefixIcon: Icon(
                    PhosphorIcons.magnifyingGlass,
                    color: CustomColors.secondary,
                    size: 7.w,
                  ),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.3.w, color: CustomColors.secondary)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.3.w, color: CustomColors.secondary)),
                  hintText: 'Search Batch name',
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w600, color: Colors.grey)),
            ),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Batches",
                  style: TextStyle(
                    fontSize: 2.4.h,
                  ),
                ),
                InkWell(
                  onTap: () => Get.to(() => const CreateBatchPage()),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text('add new batch',
                          style: TextStyle(
                            fontSize: 2.2.h,
                          )),
                      const Icon(PhosphorIcons.plusCircleFill),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            Obx(() => controller.batchesList.isEmpty
                ? Card(
                    elevation: 4,
                    shadowColor: CustomColors.secondary,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 4.w, vertical: 1.5.h),
                      child: Row(
                        children: [
                          Icon(
                            PhosphorIcons.info,
                            size: 8.w,
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'What is a batch?',
                                style: TextStyle(fontSize: 4.w),
                              ),
                              Text(
                                'A group of birds of the same age?',
                                style: TextStyle(
                                    fontSize: 3.w, color: Colors.grey),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: controller.foundBatches.length,
                        itemBuilder: (context, position) {
                          String title =
                              controller.foundBatches[position]["name"];
                          String birdType =
                              controller.foundBatches[position]["birdType"]!;
                          int birdCount =
                              controller.foundBatches[position]["birdCount"];
                          return Card(
                              elevation: 0,
                              child: ListTile(
                                  onTap: () {
                                    controller.storeItems.isEmpty
                                        ? Get.to(() => FeedStore(
                                              batchDetails: BatchModel.fromMap(
                                                  controller
                                                      .foundBatches[position]),
                                              report: "",
                                            ))
                                        : Get.to(() => NumberOfBirdsReportPage(
                                              batchDetails: BatchModel.fromMap(
                                                  controller
                                                      .foundBatches[position]),
                                            ));
                                  },
                                  title: Text(title),
                                  subtitle: Text(
                                      "${birdType.capitalize!},$birdCount Birds"),
                                  trailing: controller.foundBatches[position]
                                              ['todaysSubmission'] !=
                                          null
                                      ? SizedBox(
                                          width: 30.w,
                                          child: const LinearProgressIndicator(
                                            value: 1.0,
                                            color: CustomColors.green,
                                          ),
                                        )
                                      : Wrap(
                                          crossAxisAlignment:
                                              WrapCrossAlignment.center,
                                          children: [
                                            Text('Start Report',
                                                style: TextStyle(
                                                    fontSize: 1.5.h,
                                                    color:
                                                        CustomColors.tertiary)),
                                            const Icon(PhosphorIcons.arrowRight,
                                                color: CustomColors.tertiary),
                                          ],
                                        )));
                        }))),
            const SizedBox(
              height: CustomSpacing.s1,
            ),
          ],
        ),
      ),
    );
  }
}
