// ignore_for_file: constant_identifier_names

import 'package:dropdown_search/dropdown_search.dart';
import 'package:epoultry/core/data/data_export.dart';
import 'package:epoultry/features/farm/reports/received/feed_received.dart';
import 'package:epoultry/features/farm/reports/sawdust_used.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../core/presentation/controllers/farm_controller.dart';
import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../core/presentation/components/gradient_widget.dart';

class FeedsUsedPage extends StatefulWidget {
  const FeedsUsedPage({Key? key, required this.batchDetails, this.report})
      : super(key: key);

  final BatchModel batchDetails;

  // ignore: prefer_typing_uninitialized_variables
  final report;
  @override
  State<FeedsUsedPage> createState() => _FeedsUsedPageState();
}

// ignore: camel_case_types
// enum FEED_TYPE {
//   CHICKEN_DUCK_MASH,
//   FINISHER_PELLETS,
//   GROWERS_MASH,
//   KIENYEJI_GROWERS_MASH,
//   LAYERS_MASH,
//   STARTER_CRUMBS
// }

final Map<String, String>feed_types={
  "CHICKEN_DUCK_MASH":"Chick & Duck Mash",
  "GROWERS_MASH":"Growers Mash",
  "LAYERS_MASH":"Layers Mash",
  "KIENYEJI_GROWERS_MASH":"Kienyeji Growers Mash",
  "STARTER_CRUMBS":"Starter Crumbs",
  "FINISHER_PELLETS":"Finisher Pellets"
};
final List<String> humanize=feed_types.entries.map((e) => e.value).toList();
final List<String> machinelize=feed_types.entries.map((e) => e.key).toList();

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

  var kienyejiFeeds = ["CHICK & DUCK Mash", "Kienyeji Growers Mash"];

  var layersFeeds = [
    "CHICK & DUCK Mash",
    "Growers Mash",
    "Layers Mash",
  ];

  var broilersFeeds = [
    "Starter Crumb",
    "Finisher Pellets",
  ];

  List<String> feeds = [];

  List _selectedFeeds = [];

  final quantity = TextEditingController();
  final controller = Get.find<FarmsController>();



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
              Get.back();
            },
          ),
          title: Text(
            widget.batchDetails.name,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: Container(
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
                                items: controller.layersFeeds,
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
                                  return null;
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
                                items: controller.broilerFeeds,
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
                                  return null;
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
                                items: controller.broilerFeeds,
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
                                  return null;
                                },
                              )
                            : Container(),
                        const SizedBox(
                          height: CustomSpacing.s3,
                        ),
                        _selectedFeeds.contains("LAYERS_MASH") ||
                                _selectedFeeds.contains("Layers Mash") &&
                                    (widget.batchDetails.type!.name) ==
                                        "LAYERS"
                            ? TextFormField(
                                controller: layersMashUsed,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter amount of layers mash used';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  suffixText: 'Kgs',
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
                        _selectedFeeds.contains("GROWERS_MASH") ||
                                _selectedFeeds.contains("Growers Mash") &&
                                    (widget.batchDetails.type!.name) ==
                                        "LAYERS"
                            ? TextFormField(
                                controller: growersMashUsed,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter amount of growers mash used';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  suffixText: 'Kgs',
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
                                      "How many Kgs of growers mash were used today?",
                                  labelStyle: TextStyle(
                                      fontSize: 2.2.h,
                                      color: CustomColors.secondary),
                                ),
                              )
                            : Container(),
                        const SizedBox(
                          height: CustomSpacing.s3,
                        ),
                        _selectedFeeds.contains("Chicken Duck Mash") ||
                                _selectedFeeds
                                        .contains("Chick & Duck Mash") &&
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
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  suffixText: 'Kgs',
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
                        const SizedBox(
                          height: CustomSpacing.s2,
                        ),
                        _selectedFeeds.contains("STARTER_CRUMBS") ||
                                _selectedFeeds.contains("Starter Crumbs") &&
                                    (widget.batchDetails.type!.name) ==
                                        "BROILERS"
                            ? TextFormField(
                                controller: starterCrumbsUsed,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter amount of starter crumbs used';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  suffixText: 'Kgs',
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
                        const SizedBox(
                          height: CustomSpacing.s2,
                        ),
                        _selectedFeeds.contains("FINISHER_PELLETS") ||
                                _selectedFeeds.contains("Finisher Pellets") &&
                                    (widget.batchDetails.type!.name) ==
                                        "BROILERS"
                            ? TextFormField(
                                controller: finisherPelletsUsed,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter amount of finisher pellets used';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  suffixText: 'Kgs',
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
                        const SizedBox(
                          height: CustomSpacing.s2,
                        ),
                        _selectedFeeds.contains("KIENYEJI_GROWERS_MASH") ||
                                _selectedFeeds
                                        .contains("Kienyeji Growers Mash") &&
                                    (widget.batchDetails.type!.name) ==
                                        "KIENYEJI"
                            ? TextFormField(
                                controller: kienyejiGrowersUsed,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter amount of kienyeji growers mash used';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                  suffixText: 'Kgs',
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
                        const SizedBox(
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
                     
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  GradientWidget(
                    child: ElevatedButton(
                        onPressed: () {
                          // final DateFormat formatter = DateFormat('yyyy-MM-dd');
                          // DateTime now = DateTime.now();
                          // DateTime date =
                          //     DateTime(now.year, now.month, now.day);
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
                              ? Get.to(() => FeedReceived(
                                    batchDetails: widget.batchDetails,
                                  ))
                              : Get.to(() => SawdustUsed(
                                    batchDetails: widget.batchDetails,
                                  ));
                        }
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
                      child: Text(
                        'SAVE & CONTINUE',
                        style: TextStyle(
                            fontSize: 4.w, fontWeight: FontWeight.w700),
                      )),
                ),
                const SizedBox(
                  height: CustomSpacing.s1,
                ),
                      ]
            ),
  
          ),
        )
              ]
        )
        )));
  }
}
