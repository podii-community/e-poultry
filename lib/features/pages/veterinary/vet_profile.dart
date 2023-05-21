import 'package:epoultry/core/graphql/query_document_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:sizer/sizer.dart';

import '../../../core/controllers/user_controller.dart';
import '../../../core/data/models/error.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/widgets/gradient_widget.dart';
import '../../../core/widgets/loading_spinner.dart';
import '../../../core/widgets/success_widget.dart';

class VetProfile extends StatefulWidget {
  const VetProfile({super.key});

  @override
  State<VetProfile> createState() => _VetProfileState();
}

class _VetProfileState extends State<VetProfile> {
  final box = Hive.box('appData');
  final userController = Get.find<UserController>();

  // late final name = box.get('name');

  TextEditingController lastName = TextEditingController();

  TextEditingController firstName = TextEditingController();

  TextEditingController location = TextEditingController();

  TextEditingController idNumber = TextEditingController();

  TextEditingController phoneNumber = TextEditingController();

  TextEditingController vetNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
    String names = userController.userName.value;
    int idx = names.indexOf(" ");
    List parts = [
      names.substring(0, idx).trim(),
      names.substring(idx + 1).trim()
    ];
    firstName = TextEditingController(text: parts[0]);
    lastName = TextEditingController(text: parts[1]);
    phoneNumber = TextEditingController(text: userController.phoneNumber.value);
    vetNumber = TextEditingController(text: userController.vetNumber.value);
    idNumber = TextEditingController(text: userController.userId.value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: 8.h,
        backgroundColor: CustomColors.white,
        elevation: 0.5,
        title: const Text(
          "Complete Profile",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
        child: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: CustomSpacing.s3,
              ),
              SizedBox(
                width: double.infinity,
                height: 185,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(),
                        boxShadow: const [
                          BoxShadow(
                              color:
                                  Color.fromRGBO(0, 0, 0, 0.05000000074505806),
                              offset: Offset(0, 17.549407958984375),
                              blurRadius: 17.549407958984375)
                        ],
                        color: const Color.fromRGBO(246, 251, 255, 1),
                        border: Border.all(
                          color: const Color.fromRGBO(56, 78, 183, 1),
                          width: 0.731225311756134,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/Vector.svg',
                              semanticsLabel: 'vector'),
                          const SizedBox(height: 8),
                          Text(
                            'Upload Profile Photo',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 2.2.h, color: CustomColors.secondary
                                // color: Color.fromRGBO(1, 33, 56, 0.6000000238418579),
                                // fontFamily: 'DM Sans',
                                // fontSize: 14,
                                // letterSpacing: 0,
                                // fontWeight: FontWeight.normal,
                                // height: 1.2535291399274553
                                ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                enabled: false,
                controller: firstName,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'First Name is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "First Name",
                    labelStyle: TextStyle(
                        fontSize: 2.2.h, color: CustomColors.secondary),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0.3.w, color: CustomColors.secondary)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0.3.w, color: CustomColors.secondary))),
              ),
              const SizedBox(
                height: CustomSpacing.s3,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                enabled: false,
                controller: lastName,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Last Name is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Last Name",
                    labelStyle: TextStyle(
                        fontSize: 2.2.h, color: CustomColors.secondary),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0.3.w, color: CustomColors.secondary)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0.3.w, color: CustomColors.secondary))),
              ),
              const SizedBox(
                height: CustomSpacing.s3,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                enabled: false,
                controller: idNumber,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'ID Number is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "ID Number",
                    labelStyle: TextStyle(
                        fontSize: 2.2.h, color: CustomColors.secondary),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0.3.w, color: CustomColors.secondary)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0.3.w, color: CustomColors.secondary))),
              ),
              const SizedBox(
                height: CustomSpacing.s3,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                enabled: false,
                controller: phoneNumber,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Phone Number is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Phone Number",
                    labelStyle: TextStyle(
                        fontSize: 2.2.h, color: CustomColors.secondary),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0.3.w, color: CustomColors.secondary)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0.3.w, color: CustomColors.secondary))),
              ),
              const SizedBox(
                height: CustomSpacing.s3,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                controller: location,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'Location is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "Location",
                    labelStyle: TextStyle(
                        fontSize: 2.2.h, color: CustomColors.secondary),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0.3.w, color: CustomColors.secondary)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0.3.w, color: CustomColors.secondary))),
              ),
              const SizedBox(
                height: CustomSpacing.s3,
              ),
              TextFormField(
                keyboardType: TextInputType.text,
                enabled: false,
                controller: vetNumber,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'First Name is required';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelText: "First Name",
                    labelStyle: TextStyle(
                        fontSize: 2.2.h, color: CustomColors.secondary),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0.3.w, color: CustomColors.secondary)),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 0.3.w, color: CustomColors.secondary))),
              ),
              const SizedBox(
                height: CustomSpacing.s3,
              ),
              Mutation(
                options: MutationOptions(
                  document: gql(context.queries.updateVetProfile()),
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

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GradientWidget(
                      child: ElevatedButton(
                        onPressed: () =>
                            _updateButtonPressed(context, runMutation),
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
                          'Update Profile',
                          style: TextStyle(
                            fontSize: 2.4.h,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: CustomSpacing.s3,
              ),
              const SizedBox(
                height: CustomSpacing.s3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onCompleted(data, BuildContext context) {
    /// If they do, move to home page. If not, take them to select artist page for them to select artists.
    ///;
    ///

    if (data["updateVetOfficer"]["id"].toString().isNotEmpty) {
      userController.updateLoc(location.text);
      Get.to(
        () => const SuccessWidget(
          message: 'You have successfully updated your profile',
          route: 'extension',
        ),
      );
    }
  }

  Future<void> _updateButtonPressed(
      BuildContext context, RunMutation runMutation) async {
    runMutation({
      "data": {
        "address": {
          "county": location.text,
          "subcounty": "Kisumu East",
          "ward": "Kisumu"
        },
        "firstName": firstName.text,
        "lastName": lastName.text,
        "phoneNumber": phoneNumber.text,
      }
    });
  }
}
