import 'package:epoultry/pages/auth/login.dart';
import 'package:epoultry/pages/auth/otp_page.dart';
import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:epoultry/widgets/gradient_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../data/models/error.dart';
import '../../../theme/colors.dart';
import '../../../widgets/loading_spinner.dart';
import 'group_dashboard.dart';

class GroupRegistrationPage extends StatefulWidget {
  const GroupRegistrationPage({Key? key}) : super(key: key);

  @override
  State<GroupRegistrationPage> createState() => _GroupRegistrationPageState();
}

class _GroupRegistrationPageState extends State<GroupRegistrationPage> {
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  final _formKey = GlobalKey<FormState>();
  final location = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final name_of_contact_person = TextEditingController();
  final groupName = TextEditingController();
  final groupType = TextEditingController();
  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  @override
  void dispose() {
    phoneNumber.dispose();
    super.dispose();
  }

  void _togglePasswordStatus() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void _togglePasswordConfirmStatus() {
    setState(() {
      _obscureConfirmPassword = !_obscureConfirmPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ignore: prefer_const_constructors
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const SizedBox(
                    height: CustomSpacing.s3,
                  ),
                ),

                const SizedBox(
                  height: CustomSpacing.s1,
                ),
                Text(
                  'New Group',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 3.h),
                ),
                const SizedBox(
                  height: CustomSpacing.s3,
                ),
                Form(
                    key: _formKey,
                    child: ListView(
                      physics: const ScrollPhysics(),
                      shrinkWrap: true,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "DETAILS OF THE GROUP",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              )),
                        ),
                        TextFormField(
                          controller: groupName,
                          keyboardType: TextInputType.text,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Group Name is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Group Name",
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
                          controller: groupName,
                          keyboardType: TextInputType.phone,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Number of members is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "No. of members",
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
                          controller: groupType,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Group Type is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Group Type",
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
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "DETAILS OF CONTACT PERSON",
                                style:
                                    TextStyle(fontSize: 12, color: Colors.grey),
                              )),
                        ),
                        TextFormField(
                          controller: firstName,
                          keyboardType: TextInputType.text,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'First Name is required';
                            }
                            return null;
                          },
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
                          keyboardType: TextInputType.text,
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
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Phone Number is required';
                            }
                            return null;
                          },
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
                      ],
                    )),
                const SizedBox(
                  height: CustomSpacing.s3,
                ),
                TextFormField(
                  controller: phoneNumber,
                  keyboardType: TextInputType.phone,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Phone Number is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Type Of Birds",
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
                  controller: phoneNumber,
                  keyboardType: TextInputType.phone,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Phone Number is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Number Of Birds",
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
                  controller: phoneNumber,
                  keyboardType: TextInputType.phone,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Phone Number is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Age",
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
                  controller: phoneNumber,
                  keyboardType: TextInputType.phone,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Phone Number is required';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Days/ Weeks",
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
                    operationName: "RegisterUser",
                    document: gql(context.queries.register()),
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const GroupDashboardPage()));
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
                            'REGISTER',
                            style: TextStyle(
                              fontSize: 2.4.h,
                            ),
                          )),
                    );
                  },
                ),
                const SizedBox(
                  height: CustomSpacing.s1,
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: RichText(
                    text: TextSpan(
                        text: "Have an existing account? ",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 1.8.h,
                        ),
                        children: [
                          TextSpan(
                              text: "LOGIN",
                              style: TextStyle(
                                  color: CustomColors.secondary,
                                  fontSize: 1.8.h,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.underline),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginPage()));
                                })
                        ]),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onCompleted(data, BuildContext context) {
    var phone = phoneNumber.text.replaceFirst('0', '');
    if ((data != null)) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => OtpPage(
                  route: "register",
                  phone: phone,
                )),
      );
    }
  }

  Future<void> _registerButtonPressed(
      BuildContext context, RunMutation runMutation) async {
    runMutation(
      {
        "data": {
          'name_of_contact_person': name_of_contact_person,
          'location': location.text,
          'phoneNumber': phoneNumber.text,
          "groupName": groupName.text,
          "lastName": groupType.text,
          "password": password.text
        }
      },
    );
  }
}
