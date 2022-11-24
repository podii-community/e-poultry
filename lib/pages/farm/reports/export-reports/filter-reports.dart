
import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../../controllers/farm_controller.dart';
import '../../../../theme/colors.dart';
import '../../../../widgets/gradient_widget.dart';
import '../view_report_page.dart';

class FilterReportsPage extends StatefulWidget {
  const FilterReportsPage({Key? key}) : super(key: key);

  @override
  State<FilterReportsPage> createState() => _FilterReportsPageState();
}

class _FilterReportsPageState extends State<FilterReportsPage> {
  final _formKey = GlobalKey<FormBuilderState>();
  final startController = TextEditingController();
  final endController = TextEditingController();

  final FarmsController farmController = Get.put(FarmsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            farmController.filteredReports([]);
          },
        ),
        title: Text(
          "Export Reports",
          style: TextStyle(color: Colors.black, fontSize: 2.3.h),
        ),
      ),
      body: Container(
        height: 100.h,
        padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: CustomSpacing.s3,
              ),
              FormBuilderDateTimePicker(
                controller: startController,
                name: 'fromDate',
                initialEntryMode: DatePickerEntryMode.calendarOnly,
                inputType: InputType.date,
                format: DateFormat('yyyy-MM-dd'),

                decoration: InputDecoration(
                  labelText: 'From',
                  labelStyle:
                      TextStyle(fontSize: 2.2.h, color: CustomColors.secondary),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.3.w, color: CustomColors.secondary)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.3.w, color: CustomColors.secondary)),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      _formKey.currentState!.fields['fromDate']
                          ?.didChange(null);
                    },
                  ),
                ),
                validator: FormBuilderValidators.required(),
                // locale: const Locale.fromSubtags(languageCode: 'fr'),
              ),
              const SizedBox(
                height: CustomSpacing.s1,
              ),
              FormBuilderDateTimePicker(
                name: 'toDate',
                controller: endController,
                initialEntryMode: DatePickerEntryMode.calendarOnly,
                inputType: InputType.date,
                format: DateFormat('yyyy-MM-dd'),
                decoration: InputDecoration(
                  labelText: 'To',
                  labelStyle:
                      TextStyle(fontSize: 2.2.h, color: CustomColors.secondary),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.3.w, color: CustomColors.secondary)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.3.w, color: CustomColors.secondary)),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      _formKey.currentState!.fields['toDate']?.didChange(null);
                    },
                  ),
                ),
                validator: FormBuilderValidators.required(),
                // locale: const Locale.fromSubtags(languageCode: 'fr'),
              ),
              const SizedBox(
                height: CustomSpacing.s3,
              ),
              GradientWidget(
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // log("${DateTime.parse(startController.text)}");
                        _filterButtonPressed(context);
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: CustomColors.background, backgroundColor: Colors.transparent,
                        disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                        shadowColor: Colors.transparent,
                        fixedSize: Size(100.w, 6.h)),
                    child: Text(
                      'GENERATE REPORTS',
                      style: TextStyle(
                        fontSize: 1.8.h,
                      ),
                    )),
              ),
              Obx(
                () => farmController.filteredReports.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: farmController.filteredReports.length,
                        itemBuilder: ((context, index) {
                          return ListTile(
                            trailing: const Icon(
                              PhosphorIcons.arrowRightBold,
                              color: Colors.black,
                            ),
                            title: Text("Farm Report",
                                style: TextStyle(fontSize: 1.9.h)),
                            subtitle: Text(
                                "${farmController.filteredReports[index]["reportDate"]}"),
                            onTap: () {
                              farmController.selectedReport(
                                  farmController.filteredReports[index]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewReportPage()),
                              );
                            },
                            tileColor: CustomColors.background,
                            textColor: Colors.black,
                          );
                        }))
                    : Container(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onCompleted(data, BuildContext context) async {}

  Future<void> _filterButtonPressed(
    BuildContext context,
  ) async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    var filteredReports = await client.query(QueryOptions(
        operationName: "GetFarmReports",
        document: gql(context.queries.getFarmReports()),
        variables: {
          "filter": {
            "farmId": farmController.farm.value['id'],
            "startDate": startController.text,
            "endDate": endController.text
          }
        }));

    farmController.filteredReports(filteredReports.data!['farmReports']);
  }
}
