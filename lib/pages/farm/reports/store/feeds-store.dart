import 'dart:convert';
import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:epoultry/pages/farm/reports/store/medication-store.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:string_extensions/string_extensions.dart';

import '../../../../controllers/farm_controller.dart';
import '../../../../data/models/batch_model.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/spacing.dart';
import '../../../../widgets/gradient_widget.dart';

class FeedStore extends StatefulWidget {
  const FeedStore({Key? key, required this.batchDetails, required this.report})
      : super(key: key);

  final BatchModel batchDetails;
  final report;

  @override
  State<FeedStore> createState() => _FeedStoreState();
}

class _FeedStoreState extends State<FeedStore> {
  final _formKey = GlobalKey<FormState>();

  var kienyejiFeeds = ["Chicken Duck Mash", "Kienyeji Growers Mash"];

  var layersFeeds = [
    "Chicken Duck Mash",
    "Layers Mash",
  ];

  var broilersFeeds = [
    "Starter Crumbs",
    "Finisher Pellets",
  ];
  List _selectedFeeds = [];

  final layersMashStore = TextEditingController();
  final growersMashStore = TextEditingController();
  final chickDuckMashStore = TextEditingController();
  final starterCrumbsStore = TextEditingController();
  final finisherPelletsStore = TextEditingController();
  final kienyejiGrowersStore = TextEditingController();

  final FarmsController controller = Get.put(FarmsController());

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
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Update feeds in store",
                      style: TextStyle(fontSize: 3.h),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                    child: Card(
                      elevation: 0,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: CustomSpacing.s2,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: CustomSpacing.s2),
                              child: GridView.count(
                                shrinkWrap: true,
                                crossAxisCount: 2,
                                crossAxisSpacing: CustomSpacing.s1,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Type of Birds",
                                        style: TextStyle(
                                            color: CustomColors.secondary,
                                            fontSize: 2.h),
                                      ),
                                      Text(
                                        (widget.batchDetails.type!.name)
                                            .capitalize!,
                                        style: TextStyle(
                                            color: CustomColors.secondary,
                                            fontSize: 3.5.h,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "No of Birds",
                                        style: TextStyle(
                                            color: CustomColors.secondary,
                                            fontSize: 2.h),
                                      ),
                                      Text(
                                        "${widget.batchDetails.birdCount}",
                                        style: TextStyle(
                                            color: CustomColors.secondary,
                                            fontSize: 3.5.h,
                                            fontWeight: FontWeight.w500),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  SizedBox(
                    height: 50.h,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: CustomSpacing.s2,
                          ),
                          widget.batchDetails.type!.name == "LAYERS"
                              ? DropdownSearch<String>.multiSelection(
                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                          hintText: "--select--",
                                          labelText:
                                              "What feeds do you have in store?",
                                          labelStyle: TextStyle(
                                              fontSize: 2.0.h,
                                              color: CustomColors.secondary),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.3.w,
                                                  color:
                                                      CustomColors.secondary)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.3.w,
                                                  color: CustomColors
                                                      .secondary)))),
                                  items: layersFeeds,
                                  popupProps:
                                      const PopupPropsMultiSelection.menu(
                                    showSelectedItems: true,
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      _selectedFeeds = val;
                                    });
                                  },
                                  validator: (value) {
                                    if (_selectedFeeds.isEmpty) {
                                      return "Please choose a feed";
                                    }
                                  },
                                )
                              : Container(),
                          widget.batchDetails.type!.name == "BROILERS"
                              ? DropdownSearch<String>.multiSelection(
                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                          hintText: "--select--",
                                          labelText:
                                              "What feeds do you have in store?",
                                          labelStyle: TextStyle(
                                              fontSize: 2.0.h,
                                              color: CustomColors.secondary),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.3.w,
                                                  color:
                                                      CustomColors.secondary)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.3.w,
                                                  color: CustomColors
                                                      .secondary)))),
                                  items: broilersFeeds,
                                  popupProps:
                                      const PopupPropsMultiSelection.menu(
                                    showSelectedItems: true,
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      _selectedFeeds = val;
                                    });
                                  },
                                  validator: (value) {
                                    if (_selectedFeeds.isEmpty) {
                                      return "Please choose a feed";
                                    }
                                  },
                                )
                              : Container(),
                          widget.batchDetails.type!.name == "KIENYEJI"
                              ? DropdownSearch<String>.multiSelection(
                                  dropdownDecoratorProps: DropDownDecoratorProps(
                                      dropdownSearchDecoration: InputDecoration(
                                          hintText: "--select--",
                                          labelText:
                                              "What feeds do you have in store?",
                                          labelStyle: TextStyle(
                                              fontSize: 2.0.h,
                                              color: CustomColors.secondary),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.3.w,
                                                  color:
                                                      CustomColors.secondary)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  width: 0.3.w,
                                                  color: CustomColors
                                                      .secondary)))),
                                  items: kienyejiFeeds,
                                  popupProps:
                                      const PopupPropsMultiSelection.menu(
                                    showSelectedItems: true,
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      _selectedFeeds = val;
                                    });
                                  },
                                  validator: (value) {
                                    if (_selectedFeeds.isEmpty) {
                                      return "Please choose a feed";
                                    }
                                  },
                                )
                              : Container(),
                          const SizedBox(
                            height: CustomSpacing.s3,
                          ),
                          _selectedFeeds.contains("Layers Mash") &&
                                  (widget.batchDetails.type!.name) == "LAYERS"
                              ? TextFormField(
                                  controller: layersMashStore,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter amount of layers mash in store';
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    prefixText: 'Kgs',
                                    prefixStyle: TextStyle(fontSize: 1.8.h),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.3.w,
                                            color: CustomColors.secondary)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.3.w,
                                            color: CustomColors.secondary)),
                                    labelText:
                                        "How many Kgs of layers mash are in store?",
                                    labelStyle: TextStyle(
                                        fontSize: 2.2.h,
                                        color: CustomColors.secondary),
                                  ),
                                )
                              : Container(),
                          const SizedBox(
                            height: CustomSpacing.s3,
                          ),
                          _selectedFeeds.contains("Growers Mash") &&
                                  (widget.batchDetails.type!.name) == "LAYERS"
                              ? TextFormField(
                                  controller: growersMashStore,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter amount of broilers mash in store';
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    prefixText: 'Kgs',
                                    prefixStyle: TextStyle(fontSize: 1.8.h),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.3.w,
                                            color: CustomColors.secondary)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.3.w,
                                            color: CustomColors.secondary)),
                                    labelText:
                                        "How many Kgs of broilers mash are in store?",
                                    labelStyle: TextStyle(
                                        fontSize: 2.2.h,
                                        color: CustomColors.secondary),
                                  ),
                                )
                              : Container(),
                          const SizedBox(
                            height: CustomSpacing.s3,
                          ),
                          _selectedFeeds.contains("Chicken Duck Mash") &&
                                  ((widget.batchDetails.type!.name) ==
                                          "LAYERS" ||
                                      (widget.batchDetails.type!.name) ==
                                          "KIENYEJI")
                              ? TextFormField(
                                  controller: chickDuckMashStore,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter amount of chick duck mash in store';
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    prefixText: 'Kgs',
                                    prefixStyle: TextStyle(fontSize: 1.8.h),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.3.w,
                                            color: CustomColors.secondary)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.3.w,
                                            color: CustomColors.secondary)),
                                    labelText:
                                        "How many Kgs of chick mash are in store?",
                                    labelStyle: TextStyle(
                                        fontSize: 2.2.h,
                                        color: CustomColors.secondary),
                                  ),
                                )
                              : Container(),
                          _selectedFeeds.contains("Starter Crumbs") &&
                                  (widget.batchDetails.type!.name) == "BROILERS"
                              ? TextFormField(
                                  controller: starterCrumbsStore,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter amount of starter crumbs are in store';
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    prefixText: 'Kgs',
                                    prefixStyle: TextStyle(fontSize: 1.8.h),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.3.w,
                                            color: CustomColors.secondary)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.3.w,
                                            color: CustomColors.secondary)),
                                    labelText:
                                        "How many Kgs of starter crumbs are in store?",
                                    labelStyle: TextStyle(
                                        fontSize: 2.2.h,
                                        color: CustomColors.secondary),
                                  ),
                                )
                              : Container(),
                          _selectedFeeds.contains("Finisher Pellets") &&
                                  (widget.batchDetails.type!.name) == "BROILERS"
                              ? TextFormField(
                                  controller: finisherPelletsStore,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter amount of finisher pellets in store';
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    prefixText: 'Kgs',
                                    prefixStyle: TextStyle(fontSize: 1.8.h),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.3.w,
                                            color: CustomColors.secondary)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.3.w,
                                            color: CustomColors.secondary)),
                                    labelText:
                                        "How many Kgs of finisher pellets are in store?",
                                    labelStyle: TextStyle(
                                        fontSize: 2.2.h,
                                        color: CustomColors.secondary),
                                  ),
                                )
                              : Container(),
                          _selectedFeeds.contains("Kienyeji Growers Mash") &&
                                  (widget.batchDetails.type!.name) == "KIENYEJI"
                              ? TextFormField(
                                  controller: kienyejiGrowersStore,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter amount of kienyeji growers mash are in store';
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    prefixText: 'Kgs',
                                    prefixStyle: TextStyle(fontSize: 1.8.h),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.3.w,
                                            color: CustomColors.secondary)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            width: 0.3.w,
                                            color: CustomColors.secondary)),
                                    labelText:
                                        "How many Kgs of kienyeji growers mash are in store?",
                                    labelStyle: TextStyle(
                                        fontSize: 2.2.h,
                                        color: CustomColors.secondary),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  GradientWidget(
                    child: ElevatedButton(
                        onPressed: () {
                          DateTime now = DateTime.now();
                          DateTime date =
                              DateTime(now.year, now.month, now.day);

                          var feedsStoreReports = [
                            {
                              "feedType": "CHICKEN_DUCK_MASH",
                              "quantity": chickDuckMashStore.text.isEmpty
                                  ? 0
                                  : int.parse(chickDuckMashStore.text)
                            },
                            {
                              "feedType": "GROWERS_MASH",
                              "quantity": growersMashStore.text.isEmpty
                                  ? 0
                                  : int.parse(growersMashStore.text)
                            },
                            {
                              "feedType": "LAYERS_MASH",
                              "quantity": layersMashStore.text.isEmpty
                                  ? 0
                                  : int.parse(layersMashStore.text)
                            },
                            {
                              "feedType": "KIENYEJI_GROWERS_MASH",
                              "quantity": kienyejiGrowersStore.text.isEmpty
                                  ? 0
                                  : int.parse(kienyejiGrowersStore.text)
                            },
                            {
                              "feedType": "STARTER_CRUMBS",
                              "quantity": starterCrumbsStore.text.isEmpty
                                  ? 0
                                  : int.parse(starterCrumbsStore.text)
                            },
                            {
                              "feedType": "FINISHER_PELLETS",
                              "quantity": finisherPelletsStore.text.isEmpty
                                  ? 0
                                  : int.parse(finisherPelletsStore.text)
                            },
                          ];

                          // var report = {
                          //   "data": {"feedsStore": feedsStoreReports}
                          // };

                          controller.report["data"]!["batchId"] =
                              widget.batchDetails.id!;
                          (controller.report["data"]!["feedsReport"]!
                              as Map)["inStore"](feedsStoreReports);

                          if (_formKey.currentState!.validate()) {
                            // final data = controller.report["data"] as Map;

                            // log("${data["weightReport"]["averageWeight"]}");

                            // jsonEncode(data["weightReport"]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MedicationStore(
                                        batchDetails: widget.batchDetails,
                                      )),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Colors.transparent,
                            onSurface: Colors.transparent,
                            shadowColor: Colors.transparent,
                            onPrimary: CustomColors.background,
                            fixedSize: Size(100.w, 6.h)),
                        child: Text(
                          'UPDATE FEEDS',
                          style: TextStyle(
                              fontSize: 4.w, fontWeight: FontWeight.w700),
                        )),
                  ),
                  const SizedBox(
                    height: CustomSpacing.s1,
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
