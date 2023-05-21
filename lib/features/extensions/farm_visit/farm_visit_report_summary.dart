import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../../../core/theme/colors.dart';
import '../../../core/controllers/farm_controller.dart';
import '../../../core/theme/spacing.dart';

class FarmVisitReportSummary extends StatelessWidget {
  const FarmVisitReportSummary({Key? key, required this.extensionServiceId})
      : super(key: key);
  // ignore: prefer_typing_uninitialized_variables
  final extensionServiceId;
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FarmsController>();
    var filteredList = controller.requestsList
        .where((element) =>
            element["farmVisitReport"] != null &&
            element["id"] == extensionServiceId)
        .toList();

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Farm Visit Report',
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
            onPressed: () {
              Navigator.pop(context);
              // widget.
            },
          ),
        ),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
          child: Column(children: [
            Expanded(child: Obx(() {
              return controller.requestsList.isEmpty
                  ? Align(
                      alignment: Alignment.topLeft,
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 15),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 40),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color(0xfff6fbff)),
                        child: const Text(
                          "Your new service requests will appear here .",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> compoundMap =
                            filteredList[index]["farmVisitReport"];
                        String toBeginningOfSentenceCase(String input) {
                          return input.replaceFirst(
                              input[0], input[0].toUpperCase());
                        }

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            for (var outerEntry in compoundMap.entries)
                              if (outerEntry.key != "__typename" &&
                                  outerEntry.key != "id" &&
                                  outerEntry.value is Map)
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      toBeginningOfSentenceCase(outerEntry.key),
                                      style: TextStyle(
                                        color: Colors.grey.shade800,
                                        fontSize: 22,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    for (var innerEntry
                                        in outerEntry.value.entries)
                                      if (innerEntry.key != "__typename" &&
                                          innerEntry.key != "id")
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  " ${toBeginningOfSentenceCase(innerEntry.key)} :",
                                                  style: TextStyle(
                                                    color: Colors.grey.shade800,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                                // const SizedBox(
                                                //   width: 25,
                                                // ),
                                                Text(
                                                  "${innerEntry.value}",
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                // const Divider(),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                          ],
                                        ),
                                    const Divider(),
                                  ],
                                )
                              else if (outerEntry.key != "__typename" &&
                                  outerEntry.key != "id")
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            toBeginningOfSentenceCase(
                                                outerEntry.key),
                                            style: TextStyle(
                                              color: Colors.grey.shade800,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 2,
                                        ),
                                        Expanded(
                                          child: Text("${outerEntry.value}",
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              )),
                                        ),
                                      ],
                                    ),
                                    const Divider(),
                                  ],
                                ),
                          ],
                        );
                      });
            }))
          ]),
        ));
  }
}
