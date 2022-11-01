import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:epoultry/data/data_export.dart';
import 'package:epoultry/pages/farm/reports/received/feed-received.dart';
import 'package:epoultry/pages/farm/reports/sawdust-used.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:string_extensions/string_extensions.dart';

import '../../../controllers/farm_controller.dart';
import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../widgets/gradient_widget.dart';
import 'confirm_report_page.dart';

class FeedsUsedPage extends StatefulWidget {
  const FeedsUsedPage({Key? key, required this.batchDetails, this.report})
      : super(key: key);

  final BatchModel batchDetails;
  final report;
  @override
  State<FeedsUsedPage> createState() => _FeedsUsedPageState();
}

enum FEED_TYPE {
  // ignore: constant_identifier_names
  CHICKEN_DUCK_MASH,
  FINISHER_PELLETS,
  GROWERS_MASH,
  KIENYEJI_GROWERS_MASH,
  LAYERS_MASH,
  STARTER_CRUMBS
}

class _FeedsUsedPageState extends State<FeedsUsedPage> {
  final _formKey = GlobalKey<FormState>();
  final layersMashUsed = TextEditingController();
  final growersMashUsed = TextEditingController();
  final chickDuckMashUsed = TextEditingController();
  final starterCrumbsUsed = TextEditingController();
  final finisherPelletsUsed = TextEditingController();
  final kienyejiGrowersUsed = TextEditingController();
  // final chickMashUsed = TextEditingController();

  String feedsReceived = "";

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
                      "Update the feeds used",
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
                                              "What feeds have you used for your birds?",
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
                                              "What feeds have you used for your birds?",
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
                                              "What feeds have you used for your birds?",
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
                                  controller: layersMashUsed,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter amount of layers mash used';
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
                                        "How many Kgs of layers mash were used today?",
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
                                  controller: growersMashUsed,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter amount of broilers mash used';
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
                                        "How many Kgs of broilers mash were used today?",
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
                                  controller: chickDuckMashUsed,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter amount of chick duck mash used';
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
                                        "How many Kgs of chick mash were used today?",
                                    labelStyle: TextStyle(
                                        fontSize: 2.2.h,
                                        color: CustomColors.secondary),
                                  ),
                                )
                              : Container(),
                          _selectedFeeds.contains("Starter Crumbs") &&
                                  (widget.batchDetails.type!.name) == "BROILERS"
                              ? TextFormField(
                                  controller: starterCrumbsUsed,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter amount of starter crumbs used';
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
                                        "How many Kgs of starter crumbs were used today?",
                                    labelStyle: TextStyle(
                                        fontSize: 2.2.h,
                                        color: CustomColors.secondary),
                                  ),
                                )
                              : Container(),
                          _selectedFeeds.contains("Finisher Pellets") &&
                                  (widget.batchDetails.type!.name) == "BROILERS"
                              ? TextFormField(
                                  controller: finisherPelletsUsed,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter amount of finisher pellets used';
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
                                        "How many Kgs of finisher pellets were used today?",
                                    labelStyle: TextStyle(
                                        fontSize: 2.2.h,
                                        color: CustomColors.secondary),
                                  ),
                                )
                              : Container(),
                          _selectedFeeds.contains("Kienyeji Growers Mash") &&
                                  (widget.batchDetails.type!.name) == "KIENYEJI"
                              ? TextFormField(
                                  controller: kienyejiGrowersUsed,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter amount of kienyeji growers mash used';
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
                                        "How many Kgs of kienyeji growers mash were used today?",
                                    labelStyle: TextStyle(
                                        fontSize: 2.2.h,
                                        color: CustomColors.secondary),
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: CustomSpacing.s2,
                          ),
                          FormBuilderRadioGroup<String>(
                            decoration: InputDecoration(
                                labelText:
                                    'Have you received any new feeds today?',
                                labelStyle: TextStyle(
                                    fontSize: 3.2.h, color: Colors.black),
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 4.w),
                                border: InputBorder.none),
                            initialValue: null,
                            name: 'feedsReceived',
                            onChanged: (value) {
                              setState(() {
                                feedsReceived = value!.toLowerCase().toString();
                              });
                            },
                            validator: FormBuilderValidators.required(
                                errorText: "Choose a choice above"),
                            options: [
                              'Yes',
                              'No',
                            ]
                                .map((choice) => FormBuilderFieldOption(
                                      value: choice,
                                      child: Text(
                                        choice,
                                        style: TextStyle(
                                            fontSize: 2.2.h,
                                            color: Colors.black),
                                      ),
                                    ))
                                .toList(growable: false),
                            controlAffinity: ControlAffinity.trailing,
                          ),
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
                          var feedsUsageReports = [
                            {
                              "feedType": "CHICKEN_DUCK_MASH",
                              "quantity": chickDuckMashUsed.text.isEmpty
                                  ? 0
                                  : int.parse(chickDuckMashUsed.text)
                            },
                            {
                              "feedType": "GROWERS_MASH",
                              "quantity": growersMashUsed.text.isEmpty
                                  ? 0
                                  : int.parse(growersMashUsed.text)
                            },
                            {
                              "feedType": "LAYERS_MASH",
                              "quantity": layersMashUsed.text.isEmpty
                                  ? 0
                                  : int.parse(layersMashUsed.text)
                            },
                            {
                              "feedType": "KIENYEJI_GROWERS_MASH",
                              "quantity": kienyejiGrowersUsed.text.isEmpty
                                  ? 0
                                  : int.parse(kienyejiGrowersUsed.text)
                            },
                            {
                              "feedType": "STARTER_CRUMBS",
                              "quantity": starterCrumbsUsed.text.isEmpty
                                  ? 0
                                  : int.parse(starterCrumbsUsed.text)
                            },
                            {
                              "feedType": "FINISHER_PELLETS",
                              "quantity": finisherPelletsUsed.text.isEmpty
                                  ? 0
                                  : int.parse(finisherPelletsUsed.text)
                            },
                          ];

                          (controller.report["data"]!["feedsReport"]!
                              as Map)["used"](feedsUsageReports);

                          if (_formKey.currentState!.validate()) {
                            feedsReceived == 'yes'
                                ? Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FeedReceived(
                                              batchDetails: widget.batchDetails,
                                            )),
                                  )
                                : Navigator.push(
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
