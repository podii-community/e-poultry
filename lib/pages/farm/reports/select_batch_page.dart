import 'dart:developer';

import 'package:epoultry/data/data_export.dart';
import 'package:epoultry/pages/farm/reports/number_birds_page.dart';
import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/theme/palette.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:string_extensions/string_extensions.dart';

import '../../../controllers/farm_controller.dart';
import '../../../theme/colors.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/gradient_widget.dart';
import '../../../widgets/loading_spinner.dart';
import '../batch/create_batch_page.dart';

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

  final FarmsController controller = Get.put(FarmsController());

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
            Navigator.pop(context);
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
                  hintStyle: TextStyle(
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
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateBatchPage()),
                  ),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      Text('add new batch',
                          style: TextStyle(
                            fontSize: 2.2.h,
                          )),
                      Icon(PhosphorIcons.plusCircleFill),
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
                        itemCount: controller.batchesList.length,
                        itemBuilder: (context, position) {
                          String title =
                              controller.batchesList[position]["name"];
                          String birdType =
                              controller.batchesList[position]["birdType"]!;
                          int birdCount =
                              controller.batchesList[position]["birdCount"];
                          return Card(
                              elevation: 0,
                              child: ListTile(
                                  onTap: () {
                                    log("Batch Id,${controller.batchesList[position]}");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NumberOfBirdsReportPage(
                                                  batchDetails:
                                                      BatchModel.fromMap(
                                                          controller
                                                                  .batchesList[
                                                              position]))),
                                    );
                                  },
                                  title: Text(title),
                                  subtitle: Text(
                                      "${birdType.capitalize!},$birdCount Birds"),
                                  trailing: Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      Text('Start Report',
                                          style: TextStyle(
                                              fontSize: 1.5.h,
                                              color: CustomColors.tertiary)),
                                      Icon(PhosphorIcons.arrowRight,
                                          color: CustomColors.tertiary),
                                    ],
                                  )));
                        }))),
            // Query(
            //   options: QueryOptions(
            //     document: gql(context.queries.listBatches()),
            //     fetchPolicy: FetchPolicy.noCache,
            //     pollInterval: const Duration(minutes: 2),
            //   ),
            //   builder: (QueryResult result,
            //       {VoidCallback? refetch, FetchMore? fetchMore}) {
            //     if (result.isLoading) {
            //       return const LoadingSpinner();
            //     }
            //     if (result.hasException) {
            //       return AppErrorWidget(
            //         error: ErrorModel.fromString(
            //           result.exception.toString(),
            //         ),
            //       );
            //     }

            //     if ((result.data?['user']!["managingFarms"]).isNotEmpty) {
            //       List batches =
            //           result.data?['user']?["managingFarms"][0]["batches"];

            // return batches.isEmpty
            //     ? Card(
            //         elevation: 4,
            //         shadowColor: CustomColors.secondary,
            //         child: Padding(
            //           padding: EdgeInsets.symmetric(
            //               horizontal: 4.w, vertical: 1.5.h),
            //           child: Row(
            //             children: [
            //               Icon(
            //                 PhosphorIcons.info,
            //                 size: 8.w,
            //               ),
            //               SizedBox(
            //                 width: 2.w,
            //               ),
            //               Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     'What is a batch?',
            //                     style: TextStyle(fontSize: 4.w),
            //                   ),
            //                   Text(
            //                     'A group of birds of the same age?',
            //                     style: TextStyle(
            //                         fontSize: 3.w, color: Colors.grey),
            //                   )
            //                 ],
            //               )
            //             ],
            //           ),
            //         ),
            //       )
            //     : Expanded(
            //         child: ListView.builder(
            //             itemCount: batches.length,
            //             itemBuilder: (context, position) {
            //               String title = batches[position]["name"];
            //               String birdType =
            //                   batches[position]["birdType"]!;
            //               int birdCount = batches[position]["birdCount"];
            //               return Card(
            //                   elevation: 0,
            //                   child: ListTile(
            //                       onTap: () {
            //                         Navigator.push(
            //                           context,
            //                           MaterialPageRoute(
            //                               builder: (context) =>
            //                                   NumberOfBirdsReportPage(
            //                                       batchDetails: BatchModel
            //                                           .fromMap(batches[
            //                                               position]))),
            //                         );
            //                       },
            //                       title: Text(title),
            //                       subtitle: Text(
            //                           "${birdType.capitalize!},$birdCount Birds"),
            //                       trailing: Wrap(
            //                         crossAxisAlignment:
            //                             WrapCrossAlignment.center,
            //                         children: [
            //                           Text('Start Report',
            //                               style: TextStyle(
            //                                   fontSize: 1.5.h,
            //                                   color:
            //                                       CustomColors.tertiary)),
            //                           Icon(PhosphorIcons.arrowRight,
            //                               color: CustomColors.tertiary),
            //                         ],
            //                       )));
            //             }));
            //     }

            //     if ((result.data?['user']!["ownedFarms"]).isNotEmpty) {
            //       List batches =
            //           result.data?['user']?["ownedFarms"][0]["batches"];

            //       return batches.isEmpty
            //           ? Card(
            //               elevation: 4,
            //               shadowColor: CustomColors.secondary,
            //               child: Padding(
            //                 padding: EdgeInsets.symmetric(
            //                     horizontal: 4.w, vertical: 1.5.h),
            //                 child: Row(
            //                   children: [
            //                     Icon(
            //                       PhosphorIcons.info,
            //                       size: 8.w,
            //                     ),
            //                     SizedBox(
            //                       width: 2.w,
            //                     ),
            //                     Column(
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Text(
            //                           'What is a batch?',
            //                           style: TextStyle(fontSize: 4.w),
            //                         ),
            //                         Text(
            //                           'A group of birds of the same age?',
            //                           style: TextStyle(
            //                               fontSize: 3.w, color: Colors.grey),
            //                         )
            //                       ],
            //                     )
            //                   ],
            //                 ),
            //               ),
            //             )
            //           : Expanded(
            //               child: ListView.builder(
            //                   itemCount: batches.length,
            //                   itemBuilder: (context, position) {
            //                     return Card(
            //                         elevation: 0,
            //                         child: ListTile(
            //                             onTap: () {
            //                               Navigator.push(
            //                                 context,
            //                                 MaterialPageRoute(
            //                                     builder: (context) =>
            //                                         NumberOfBirdsReportPage(
            //                                             batchDetails: BatchModel
            //                                                 .fromMap(batches[
            //                                                     position]))),
            //                               );
            //                             },
            //                             // selected: selectedBatch?.id ==
            //                             //     batches[position]["id"],
            //                             title: Text(
            //                                 "${batches[position]["name"]}"),
            //                             subtitle: Text(
            //                                 "${batches[position]["birdType"]},${batches[position]["birdCount"]}"),
            //                             trailing: Wrap(
            //                               crossAxisAlignment:
            //                                   WrapCrossAlignment.center,
            //                               children: [
            //                                 Text('Start Report',
            //                                     style: TextStyle(
            //                                         fontSize: 1.5.h,
            //                                         color:
            //                                             CustomColors.tertiary)),
            //                                 Icon(PhosphorIcons.arrowRight,
            //                                     color: CustomColors.tertiary),
            //                               ],
            //                             )));
            //                   }));
            //     }

            //     return Container();
            //   },
            // ),

            // GradientWidget(
            //   child: ElevatedButton(
            //       onPressed: selectedBatch == null
            //           ? null
            //           : () {
            //               Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => NumberOfBirdsReportPage(
            //                           batchDetails: selectedBatch!,
            //                         )),
            //               );
            //             },
            //       style: ElevatedButton.styleFrom(
            //           primary: Colors.transparent,
            //           onSurface: Colors.transparent,
            //           shadowColor: Colors.transparent,
            //           onPrimary: CustomColors.background,
            //           fixedSize: Size(100.w, 6.h)),
            //       child: const Text('START REPORT')),
            // ),
            const SizedBox(
              height: CustomSpacing.s1,
            ),
          ],
        ),
      ),
    );
  }
}
