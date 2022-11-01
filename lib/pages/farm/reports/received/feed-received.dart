import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:string_extensions/string_extensions.dart';

import '../../../../controllers/farm_controller.dart';
import '../../../../data/models/batch_model.dart';
import '../../../../theme/colors.dart';
import '../../../../theme/spacing.dart';
import '../../../../widgets/gradient_widget.dart';
import '../sawdust-used.dart';

class FeedReceived extends StatefulWidget {
  const FeedReceived({Key? key, required this.batchDetails, this.report})
      : super(key: key);

  final BatchModel batchDetails;
  final report;

  @override
  State<FeedReceived> createState() => _FeedReceivedState();
}

class _FeedReceivedState extends State<FeedReceived> {
  final _formKey = GlobalKey<FormState>();
  final layersMashReceived = TextEditingController();
  final growersMashReceived = TextEditingController();
  final chickDuckMashReceived = TextEditingController();
  final starterCrumbsReceived = TextEditingController();
  final finisherPelletsReceived = TextEditingController();
  final kienyejiGrowersReceived = TextEditingController();
  // final chickMashReceived = TextEditingController();

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

  final quantity = TextEditingController();
  final FarmsController controller = Get.put(FarmsController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
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
                      "Update the feeds received",
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
                                              "What feeds have you received for your birds?",
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
                                              "What feeds have you received for your birds?",
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
                                              "What feeds have you received for your birds?",
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
                                  controller: layersMashReceived,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter amount of layers mash received';
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
                                        "How many Kgs of layers mash were received today?",
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
                                  controller: growersMashReceived,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter amount of broilers mash received';
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
                                        "How many Kgs of broilers mash were received today?",
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
                                  controller: chickDuckMashReceived,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter amount of chick duck mash received';
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
                                        "How many Kgs of chick mash were received today?",
                                    labelStyle: TextStyle(
                                        fontSize: 2.2.h,
                                        color: CustomColors.secondary),
                                  ),
                                )
                              : Container(),
                          _selectedFeeds.contains("Starter Crumbs") &&
                                  (widget.batchDetails.type!.name) == "BROILERS"
                              ? TextFormField(
                                  controller: starterCrumbsReceived,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter amount of starter crumbs received';
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
                                        "How many Kgs of starter crumbs were received today?",
                                    labelStyle: TextStyle(
                                        fontSize: 2.2.h,
                                        color: CustomColors.secondary),
                                  ),
                                )
                              : Container(),
                          _selectedFeeds.contains("Finisher Pellets") &&
                                  (widget.batchDetails.type!.name) == "BROILERS"
                              ? TextFormField(
                                  controller: finisherPelletsReceived,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter amount of finisher pellets received';
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
                                        "How many Kgs of finisher pellets were received today?",
                                    labelStyle: TextStyle(
                                        fontSize: 2.2.h,
                                        color: CustomColors.secondary),
                                  ),
                                )
                              : Container(),
                          _selectedFeeds.contains("Kienyeji Growers Mash") &&
                                  (widget.batchDetails.type!.name) == "KIENYEJI"
                              ? TextFormField(
                                  controller: kienyejiGrowersReceived,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter amount of kienyeji growers mash received';
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
                                        "How many Kgs of kienyeji growers mash were received today?",
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
                          final DateFormat formatter = DateFormat('yyyy-MM-dd');
                          DateTime now = DateTime.now();
                          DateTime date =
                              DateTime(now.year, now.month, now.day);
                          var feedsReceivedReports = [
                            {
                              "feedType": "CHICKEN_DUCK_MASH",
                              "quantity": chickDuckMashReceived.text.isEmpty
                                  ? 0
                                  : int.parse(chickDuckMashReceived.text)
                            },
                            {
                              "feedType": "GROWERS_MASH",
                              "quantity": growersMashReceived.text.isEmpty
                                  ? 0
                                  : int.parse(growersMashReceived.text)
                            },
                            {
                              "feedType": "LAYERS_MASH",
                              "quantity": layersMashReceived.text.isEmpty
                                  ? 0
                                  : int.parse(layersMashReceived.text)
                            },
                            {
                              "feedType": "KIENYEJI_GROWERS_MASH",
                              "quantity": kienyejiGrowersReceived.text.isEmpty
                                  ? 0
                                  : int.parse(kienyejiGrowersReceived.text)
                            },
                            {
                              "feedType": "STARTER_CRUMBS",
                              "quantity": starterCrumbsReceived.text.isEmpty
                                  ? 0
                                  : int.parse(starterCrumbsReceived.text)
                            },
                            {
                              "feedType": "FINISHER_PELLETS",
                              "quantity": finisherPelletsReceived.text.isEmpty
                                  ? 0
                                  : int.parse(finisherPelletsReceived.text)
                            },
                          ];

                          (controller.report["data"]!["feedsReport"]!
                              as Map)["received"](feedsReceivedReports);

                          if (_formKey.currentState!.validate()) {
                            log("${controller.report["data"]}");
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SawdustUsed(
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
                          'SAVE & CONTINUE',
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
