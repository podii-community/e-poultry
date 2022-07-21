import 'package:epoultry/models/batch_model.dart';
import 'package:epoultry/pages/farm/batch/confirm_batch_page.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../widgets/gradient_widget.dart';

class CreateBatchPage extends StatefulWidget {
  CreateBatchPage({Key? key}) : super(key: key);

  @override
  State<CreateBatchPage> createState() => _CreateBatchPageState();
}

class _CreateBatchPageState extends State<CreateBatchPage> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final number = TextEditingController();
  final age = TextEditingController();
  final day = TextEditingController();
  final year = TextEditingController();

  var type = ["", "Broilers", "Layers", "Kienyeji"];

  var units = ["", "Days", "Weeks", "Months"];

  var months = [
    "",
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  String initialType = "";

  String initialUnit = "";

  String initialMonth = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
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
            },
          ),
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const SizedBox(
                height: CustomSpacing.s2,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Create a New Batch",
                  style: TextStyle(fontSize: 3.h),
                ),
              ),
              const SizedBox(
                height: CustomSpacing.s2,
              ),
              Container(
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: name,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              labelText: "Batch Name",
                              labelStyle: TextStyle(fontSize: 2.2.h),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.3.w,
                                      color: CustomColors.secondary)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 0.3.w,
                                      color: CustomColors.secondary))),
                        ),
                        const SizedBox(
                          height: CustomSpacing.s3,
                        ),
                        GridView(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2.1,
                            mainAxisSpacing: CustomSpacing.s2,
                            crossAxisSpacing: CustomSpacing.s2,
                          ),
                          children: [
                            DropdownButtonFormField(
                              // Initial Value
                              key: UniqueKey(),
                              value: initialType,
                              isExpanded: true,
                              elevation: 0,
                              decoration: InputDecoration(
                                  hintText: "--select--",
                                  labelText: "Type of Birds",
                                  labelStyle: TextStyle(
                                      fontSize: 2.2.h,
                                      color: CustomColors.secondary),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.3.w,
                                          color: CustomColors.secondary)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.3.w,
                                          color: CustomColors.secondary))),

                              items: type.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  initialType = newValue!;
                                });
                              },
                            ),
                            TextFormField(
                              controller: number,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: "Number of Birds",
                                  labelStyle: TextStyle(fontSize: 2.2.h),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.3.w,
                                          color: CustomColors.secondary)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.3.w,
                                          color: CustomColors.secondary))),
                            ),
                            TextFormField(
                              controller: age,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: "Age",
                                  labelStyle: TextStyle(fontSize: 2.2.h),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.3.w,
                                          color: CustomColors.secondary)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.3.w,
                                          color: CustomColors.secondary))),
                            ),
                            DropdownButtonFormField(
                              // Initial Value
                              key: UniqueKey(),
                              value: initialUnit,
                              isExpanded: true,
                              elevation: 0,
                              decoration: InputDecoration(
                                  hintText: "--select--",
                                  labelText: "Days/Weeks/Months",
                                  labelStyle: TextStyle(
                                      fontSize: 2.2.h,
                                      color: CustomColors.secondary),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.3.w,
                                          color: CustomColors.secondary)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.3.w,
                                          color: CustomColors.secondary))),

                              items: units.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  initialUnit = newValue!;
                                });
                              },
                            ),
                          ],
                        ),
                        GridView(
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  crossAxisSpacing: CustomSpacing.s1),
                          children: [
                            TextFormField(
                              controller: day,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: "Day",
                                  labelStyle: TextStyle(fontSize: 2.2.h),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.3.w,
                                          color: CustomColors.secondary)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.3.w,
                                          color: CustomColors.secondary))),
                            ),
                            DropdownButtonFormField(
                              // Initial Value
                              key: UniqueKey(),
                              value: initialMonth,
                              isExpanded: true,
                              elevation: 0,
                              decoration: InputDecoration(
                                  hintText: "--select--",
                                  labelText: "Month",
                                  labelStyle: TextStyle(
                                      fontSize: 2.2.h,
                                      color: CustomColors.secondary),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.3.w,
                                          color: CustomColors.secondary)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.3.w,
                                          color: CustomColors.secondary))),

                              items: months.map((String items) {
                                return DropdownMenuItem(
                                  value: items,
                                  child: Text(items),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  initialMonth = newValue!;
                                });
                              },
                            ),
                            TextFormField(
                              controller: year,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  labelText: "Year",
                                  labelStyle: TextStyle(fontSize: 2.2.h),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.3.w,
                                          color: CustomColors.secondary)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 0.3.w,
                                          color: CustomColors.secondary))),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
              GradientWidget(
                child: ElevatedButton(
                    onPressed: () {
                      Batches newBatch = Batches(
                          name: name.text,
                          type: initialType,
                          quantity: number.text,
                          age: age.text,
                          units: initialUnit,
                          date: (day.text +
                              " " +
                              initialMonth +
                              " " +
                              year.text));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ConfirmBatchPage(
                                  newBatch: newBatch,
                                )),
                      );
                    },
                    child: Text('CREATE BATCH'),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.transparent,
                        onSurface: Colors.transparent,
                        shadowColor: Colors.transparent,
                        onPrimary: CustomColors.background,
                        fixedSize: Size(100.w, 6.h))),
              ),
            ])));
  }
}
