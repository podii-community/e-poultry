import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../data/models/error.dart';
import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/gradient_widget.dart';
import '../../../widgets/loading_spinner.dart';
import '../../../widgets/success_widget.dart';
import '../dashboard/farm_dashboard_page.dart';

class CreateFarmPage extends StatefulWidget {
  const CreateFarmPage({Key? key}) : super(key: key);

  @override
  State<CreateFarmPage> createState() => _CreateFarmPageState();
}

class _CreateFarmPageState extends State<CreateFarmPage> {
  final _formKey = GlobalKey<FormState>();
  final farmName = TextEditingController();
  final locationName = TextEditingController();
  String contractorManaged = "";
  String farmLocation = "";
  late Position farmCoordinates;
  final contractorName = TextEditingController();
  bool locating = false;
  var locations = [
    "",
    'Vihiga',
    'Kisumu',
  ];

  var contractors = ["", "Chicken Basket", "Contractors 1"];

  void _determinePosition() async {
    setState(() {
      locating = true;
    });
    Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    farmCoordinates = pos;

    List<Placemark> placemarks =
        await placemarkFromCoordinates(pos.latitude, pos.longitude);

    setState(() {
      locating = false;

      locationName.text =
          "${placemarks.first.locality!}, ${placemarks.first.administrativeArea!}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          },
        ),
      ),
      // resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: CustomSpacing.s1,
                ),
                Text(
                  'Create a farm',
                  style: TextStyle(fontSize: 3.h),
                ),
                const SizedBox(
                  height: CustomSpacing.s3,
                ),
                Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        TextFormField(
                          controller: farmName,
                          keyboardType: TextInputType.text,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Farm Name is required';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: "Farm Name",
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
                        ),
                        const SizedBox(
                          height: CustomSpacing.s3,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          controller: locationName,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Location is required';
                            }
                          },
                          decoration: InputDecoration(
                              labelText: "Select the location of your farm",
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
                        ),
                        const SizedBox(height: CustomSpacing.s2),
                        locating
                            ? const LinearProgressIndicator(
                                color: CustomColors.primary,
                              )
                            : RichText(
                                text: TextSpan(
                                    text: "Locate Me",
                                    style: const TextStyle(
                                        color: CustomColors.secondary),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        _determinePosition();
                                      })),

                        const SizedBox(
                          height: CustomSpacing.s3,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Is your Farm Managed by a Contractor",
                              style: TextStyle(
                                fontSize: 2.2.h,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 40.w,
                                  child: ListTile(
                                    title: const Text('Yes'),
                                    leading: Radio<String>(
                                      value: "yes",
                                      groupValue: contractorManaged,
                                      onChanged: (value) {
                                        setState(() {
                                          contractorManaged = value.toString();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 40.w,
                                  child: ListTile(
                                    title: const Text('No'),
                                    leading: Radio<String>(
                                      value: "no",
                                      groupValue: contractorManaged,
                                      onChanged: (value) {
                                        setState(() {
                                          contractorManaged = value.toString();
                                          contractorName.clear();
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),

                        Query(
                          options: QueryOptions(
                            document: gql(context.queries.getContractors()),
                            fetchPolicy: FetchPolicy.noCache,
                            pollInterval: const Duration(minutes: 2),
                          ),
                          builder: (QueryResult result,
                              {VoidCallback? refetch, FetchMore? fetchMore}) {
                            if (result.isLoading) {
                              return const LoadingSpinner();
                            }
                            if (result.hasException) {
                              return AppErrorWidget(
                                error: ErrorModel.fromString(
                                  result.exception.toString(),
                                ),
                              );
                            }

                            List contractors = result.data?["contractors"];

                            contractorName.text = contractors.first["id"];
                            return contractorManaged == 'yes'
                                ? DropdownButtonFormField<String>(
                                    value: contractorName.text,
                                    onChanged: (contractorId) => setState(() =>
                                        contractorName.text = contractorId!),
                                    validator: (value) =>
                                        value == null ? 'field required' : null,
                                    items: contractors.map((value) {
                                      return DropdownMenuItem(
                                        value: value["id"].toString(),
                                        child: Text(value["name"]),
                                      );
                                    }).toList(),
                                    decoration: InputDecoration(
                                        labelText: "Select the contractor",
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
                                                color:
                                                    CustomColors.secondary))))
                                : Container();
                          },
                        ),

                        // DropdownButtonFormField(
                        //     items: items, onChanged: onChanged)
                      ],
                    )),
                const SizedBox(
                  height: CustomSpacing.s3,
                ),
                Mutation(
                  options: MutationOptions(
                    operationName: "CreateFarm",
                    document: gql(context.queries.createFarm()),
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
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              _createButtonPressed(context, runMutation);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              onSurface: Colors.transparent,
                              shadowColor: Colors.transparent,
                              onPrimary: CustomColors.background,
                              fixedSize: Size(100.w, 6.h)),
                          child: Text(
                            'CREATE FARM',
                            style: TextStyle(
                              fontSize: 1.8.h,
                            ),
                          )),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onCompleted(data, BuildContext context) async {
    /// If they do, move to home page. If not, take them to select artist page for them to select artists.
    if ((data['createFarm']['id'] != null)) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FarmDashboardPage()),
      );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const SuccessWidget(
                    message: 'Farm Created',
                    route: 'dashboard',
                  )));
    }
  }

  Future<void> _createButtonPressed(
      BuildContext context, RunMutation runMutation) async {
    runMutation({
      "data": {
        'areaName': locationName.text,
        "contractorId": contractorName.text,
        "latitude": farmCoordinates.latitude,
        "longitude": farmCoordinates.longitude,
        "name": farmName.text
      },
    });
  }
}
