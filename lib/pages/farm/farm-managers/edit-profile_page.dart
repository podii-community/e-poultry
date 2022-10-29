import 'dart:developer';

import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/widgets/gradient_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../controllers/user_controller.dart';
import '../../../data/models/error.dart';
import '../../../theme/colors.dart';
import '../../../theme/spacing.dart';
import '../../../widgets/loading_spinner.dart';
import '../../../widgets/success_widget.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController recoveryPhoneNumber = TextEditingController();
  TextEditingController title = TextEditingController();
  final box = Hive.box('appData');

  final UserController userController = Get.put(UserController());

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
    phoneNumber = TextEditingController(text: box.get('phone'));
    recoveryPhoneNumber = TextEditingController(text: box.get('phone'));
    title = TextEditingController(text: box.get('role'));
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
          leading: IconButton(
            icon: const Icon(
              PhosphorIcons.arrowLeft,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "Edit Profile",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
            child: Column(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: CustomSpacing.s3,
                        ),
                        TextFormField(
                          controller: firstName,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              labelText: "First Name",
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
                          controller: lastName,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                              labelText: "Last Name",
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
                          controller: phoneNumber,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              labelText: "Phone Number",
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
                          enabled: false,
                          controller: recoveryPhoneNumber,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              labelText: "Recovery Phone Number",
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
                          enabled: false,
                          controller: title,
                          keyboardType: TextInputType.text,
                          readOnly: true,
                          decoration: InputDecoration(
                              labelText: "Title",
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
                      ],
                    )),
              ),
              Mutation(
                options: MutationOptions(
                  document: gql(context.queries.updateProfile()),
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
                              primary: Colors.transparent,
                              onSurface: Colors.transparent,
                              shadowColor: Colors.transparent,
                              onPrimary: CustomColors.background,
                              fixedSize: Size(100.w, 6.h)),
                          child: const Text('SAVE')),
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
            ]),
          ),
        ));
  }

  void _onCompleted(data, BuildContext context) {
    /// If they do, move to home page. If not, take them to select artist page for them to select artists.
    ///;
    ///
    log("$data");

    if (data["updateUser"]["id"].toString().isNotEmpty) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const SuccessWidget(
                    message: 'You have successfully updated your profile',
                    route: 'dashboard',
                  )));
    }
  }

  Future<void> _updateButtonPressed(
      BuildContext context, RunMutation runMutation) async {
    runMutation({
      "data": {
        "firstName": firstName.text,
        "lastName": lastName.text,
        "phoneNumber": phoneNumber.text,
        "recoveryPhoneNumber": recoveryPhoneNumber.text,
      }
    });
  }
}
