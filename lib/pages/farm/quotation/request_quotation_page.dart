import 'package:dropdown_search/dropdown_search.dart';
import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../data/models/error.dart';
import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../widgets/gradient_widget.dart';
import '../../../widgets/loading_spinner.dart';
import '../../../widgets/success_widget.dart';

class RequestQuotationPage extends StatefulWidget {
  const RequestQuotationPage({Key? key}) : super(key: key);

  @override
  State<RequestQuotationPage> createState() => _RequestQuotationPageState();
}

class _RequestQuotationPageState extends State<RequestQuotationPage> {
  final _formKey = GlobalKey<FormState>();
  List selectedTypes = [];

  final layerBirds = TextEditingController();
  final broilerBirds = TextEditingController();
  final kienyejiBirds = TextEditingController();

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
                "Request a quotation",
                style: TextStyle(fontSize: 3.h),
              ),
            ),
            const SizedBox(
              height: CustomSpacing.s2,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  DropdownSearch<String>.multiSelection(
                    dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                            hintText: "--select--",
                            labelText: "What type do you want to keep",
                            labelStyle: TextStyle(
                                fontSize: 2.2.h, color: CustomColors.secondary),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.3.w,
                                    color: CustomColors.secondary)),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.3.w,
                                    color: CustomColors.secondary)))),
                    items: const [
                      'Layers',
                      'Broilers',
                      'Kienyeji',
                    ],
                    popupProps: const PopupPropsMultiSelection.menu(
                      showSelectedItems: true,
                    ),
                    onChanged: (val) {
                      setState(() {
                        selectedTypes = val;
                      });
                    },
                  ),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  selectedTypes.contains("Layers")
                      ? DropdownSearch<String>(
                          popupProps: const PopupProps.menu(
                            showSelectedItems: true,
                          ),
                          items: const [
                            "100",
                            "250",
                            "500",
                            "750",
                            "1000",
                            "More than 1000"
                          ],
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  hintText: "--select--",
                                  labelText:
                                      "How many layer birds do you want to keep",
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
                                          color: CustomColors.secondary)))),
                          onChanged: (val) {
                            setState(() {
                              layerBirds.text = val!;
                            });
                          },
                        )
                      : Container(),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  selectedTypes.contains("Broilers")
                      ? DropdownSearch<String>(
                          popupProps: const PopupProps.menu(
                            showSelectedItems: true,
                          ),
                          items: const [
                            "100",
                            "250",
                            "500",
                            "750",
                            "1000",
                            "More than 1000"
                          ],
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  hintText: "--select--",
                                  labelText:
                                      "How many broiler birds  do you want to keep",
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
                                          color: CustomColors.secondary)))),
                          onChanged: (val) {
                            setState(() {
                              broilerBirds.text = val!;
                            });
                          },
                        )
                      : Container(),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                  selectedTypes.contains("Kienyeji")
                      ? DropdownSearch<String>(
                          popupProps: const PopupProps.menu(
                            showSelectedItems: true,
                          ),
                          items: const [
                            "100",
                            "250",
                            "500",
                            "750",
                            "1000",
                            "More than 1000"
                          ],
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  hintText: "--select--",
                                  labelText:
                                      "How many Kienyeji birds  do you want to keep",
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
                                          color: CustomColors.secondary)))),
                          onChanged: (val) {
                            setState(() {
                              kienyejiBirds.text = val!;
                            });
                          },
                        )
                      : Container(),
                  const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                ],
              ),
            ),
            Mutation(
              options: MutationOptions(
                document: gql(context.queries.requestQuotation()),
                onCompleted: (data) => _onCompleted(data, context),
              ),
              builder: (RunMutation runMutation, QueryResult? result) {
                if (result != null) {
                  if (result.isLoading) {
                    return const LoadingSpinner();
                  }

                  if (result.hasException) {
                    context.showError(
                      ErrorModel.fromGraphError(
                        result.exception?.graphqlErrors ?? [],
                      ),
                    );
                  }
                }

                return GradientWidget(
                  child: ElevatedButton(
                      onPressed: () =>
                          _requestQuotationPressed(context, runMutation),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          onSurface: Colors.transparent,
                          shadowColor: Colors.transparent,
                          onPrimary: CustomColors.background,
                          fixedSize: Size(100.w, 6.h)),
                      child: const Text('REQUEST A QUOTATION')),
                );
              },
            ),
          ])),
    );
  }

  Future<void> _onCompleted(data, BuildContext context) async {
    if ((data['requestQuotation']['createdAt']).toString().isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const SuccessWidget(
                    message:
                        'You quotation request has been received.Youll receive a notification with the quotation in 48 hours',
                    route: 'dashboard',
                  )));
    }
  }

  Future<void> _requestQuotationPressed(
      BuildContext context, RunMutation runMutation) async {
    runMutation({
      "data": {
        "items": [
          {
            "name": "Kienyeji",
            "quantity":
                kienyejiBirds.text.isEmpty ? 0 : int.parse(kienyejiBirds.text)
          },
          {
            "name": "Broilers",
            "quantity":
                broilerBirds.text.isEmpty ? 0 : int.parse(broilerBirds.text)
          },
          {
            "name": "Layers",
            "quantity": layerBirds.text.isEmpty ? 0 : int.parse(layerBirds.text)
          },
        ]
      },
    });
  }
}
