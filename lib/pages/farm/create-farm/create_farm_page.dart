import 'package:dropdown_search/dropdown_search.dart';
import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/farm_controller.dart';
import '../../../data/models/error.dart';
import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../widgets/error_widget.dart';
import '../../../widgets/gradient_widget.dart';
import '../../../widgets/loading_spinner.dart';
import '../../../widgets/success_widget.dart';

class CreateFarmPage extends StatefulWidget {
  const CreateFarmPage({Key? key}) : super(key: key);

  @override
  State<CreateFarmPage> createState() => _CreateFarmPageState();
}

class _CreateFarmPageState extends State<CreateFarmPage> {
  final _formKey = GlobalKey<FormState>();
  final farmName = TextEditingController();
  final countyName = TextEditingController();
  final subcountyName = TextEditingController();
  final wardName = TextEditingController();
  String contractorManaged = "";
  String farmLocation = "";
  List<String> _currentWards = [];
  String _chosenSubCounty = "";
  late Position farmCoordinates;
  final contractorName = TextEditingController();
  bool locating = false;
  final List<String> locations = [
    "Kisumu",
    "Siaya",
    "Busia",
    "Bungoma",
    "Vihiga",
    "Kakamega",
    "Homabay",
    "Migori",
    "Transnzoia",
    "Kisii"
  ];

  // List<Map<String, String>> addresses = [];
  List addresses = [];

  List<String> subcounties = [];
  Map<String, List> wards = {};

  String _selectedLocation = "";

  final FarmsController controller = Get.put(FarmsController());

  var contractors = ["", "Chicken Basket", "Contractors 1"];

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
                            return null;
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
                        DropdownSearch<String>(
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  hintText: "--select--",
                                  labelText: "Choose farm location",
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
                          items: locations,
                          popupProps: const PopupPropsMultiSelection.menu(
                            showSelectedItems: true,
                          ),
                          onChanged: (val) {
                            _selectedLocation = val!;
                            setState(() {
                              countyName.text = val!;
                            });
                            searchAddress(context);
                          },
                          validator: (value) {
                            if (countyName.text.isEmpty) {
                              return "Please choose a location";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: CustomSpacing.s2,
                        ),
                        DropdownSearch<String>(
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  hintText: "--select--",
                                  labelText: "Choose subcounty",
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
                          items: subcounties,
                          popupProps: const PopupPropsMultiSelection.menu(
                            showSelectedItems: true,
                          ),
                          onChanged: (val) {
                            setState(() {
                              _chosenSubCounty = val!;
                              _currentWards = wards[_chosenSubCounty]
                                      ?.map((item) => item as String)
                                      .toList() ??
                                  [];
                              subcountyName.text = val!;
                            });
                          },
                          validator: (value) {
                            if (subcountyName.text.isEmpty) {
                              return "Please choose a subcounty";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(
                          height: CustomSpacing.s2,
                        ),
                        DropdownSearch<String>(
                          dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                  hintText: "--select--",
                                  labelText: "Choose ward",
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
                          items: _currentWards,
                          popupProps: const PopupPropsMultiSelection.menu(
                            showSelectedItems: true,
                          ),
                          onChanged: (val) {
                            setState(() {
                              wardName.text = val!;
                            });
                          },
                          validator: (value) {
                            if (subcountyName.text.isEmpty) {
                              return "Please choose a subcounty";
                            }
                            return null;
                          },
                        ),

                        const SizedBox(
                          height: CustomSpacing.s3,
                        ),
                        Column(
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
                              foregroundColor: CustomColors.background,
                              backgroundColor: Colors.transparent,
                              disabledForegroundColor:
                                  Colors.transparent.withOpacity(0.38),
                              disabledBackgroundColor:
                                  Colors.transparent.withOpacity(0.12),
                              shadowColor: Colors.transparent,
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
      controller.farm(data['createFarm']);
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
        "address": {
          'county': countyName.text,
          'subcounty': subcountyName.text,
          'ward': wardName.text
        },
        "contractorId": contractorName.text,
        "name": farmName.text
      },
    });
  }

  Future<void> searchAddress(
    BuildContext context,
  ) async {
    GraphQLClient client = GraphQLProvider.of(context).value;
    var searchAddresses = await client.query(QueryOptions(
        operationName: "SearchAddress",
        document: gql(context.queries.searchAddress()),
        variables: {"query": _selectedLocation}));

    addresses = searchAddresses.data!["searchAddresses"];
    var holder = Set<String>();

    addresses.where((entry) => holder.add(entry["subcounty"]!)).toList();
    subcounties = holder.toList();
    print(subcounties);
    wards.clear();
    for (var sub in subcounties) {
      var w = addresses
          .where((address) => sub == address["subcounty"])
          .map((item) => item["ward"])
          .toList();
      wards.addAll({sub: w});
    }
  }
}
