import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';
import 'package:string_extensions/string_extensions.dart';

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
  var typeOfFeeds = ["Layers Mash", "Broilers Mash", "Chick Mash"];
  List _selectedFeeds = [];

  final layersMashUsed = TextEditingController();
  final broilersMashUsed = TextEditingController();
  final chickMashUsed = TextEditingController();

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
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: CustomSpacing.s2,
                        ),
                        DropdownSearch<String>.multiSelection(
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  hintText: "--select--",
                                  labelText: "What feeds do you have in store?",
                                  labelStyle: TextStyle(
                                      fontSize: 2.0.h,
                                      color: CustomColors.secondary),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.3.w,
                                          color: CustomColors.secondary)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.3.w,
                                          color: CustomColors.secondary)))),
                          items: typeOfFeeds,
                          popupProps: const PopupPropsMultiSelection.menu(
                            showSelectedItems: true,
                          ),
                          onChanged: (val) {
                            setState(() {
                              _selectedFeeds = val;
                            });
                          },
                        ),
                        const SizedBox(
                          height: CustomSpacing.s3,
                        ),
                        _selectedFeeds.contains("Layers Mash")
                            ? TextFormField(
                                controller: layersMashUsed,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Layers mash in store';
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
                                  labelText: "Layers mash in store?",
                                  labelStyle: TextStyle(
                                      fontSize: 2.2.h,
                                      color: CustomColors.secondary),
                                ),
                              )
                            : Container(),
                        const SizedBox(
                          height: CustomSpacing.s3,
                        ),
                        _selectedFeeds.contains("Broilers Mash")
                            ? TextFormField(
                                controller: broilersMashUsed,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Broilers mash in store';
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
                                  labelText: "Broilers mash in store?",
                                  labelStyle: TextStyle(
                                      fontSize: 2.2.h,
                                      color: CustomColors.secondary),
                                ),
                              )
                            : Container(),
                        const SizedBox(
                          height: CustomSpacing.s3,
                        ),
                        _selectedFeeds.contains("Chick Mash")
                            ? TextFormField(
                                controller: chickMashUsed,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Enter amount of chick mash in store';
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
                                  labelText: "Chick mash in store?",
                                  labelStyle: TextStyle(
                                      fontSize: 2.2.h,
                                      color: CustomColors.secondary),
                                ),
                              )
                            : Container(),
                      ],
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
