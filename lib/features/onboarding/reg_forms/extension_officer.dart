import 'package:epoultry/features/auth/login.dart';
import 'package:epoultry/features/auth/otp_page.dart';
import 'package:epoultry/core/data/data_source/graphql/query_document_provider.dart';
import 'package:epoultry/theme/spacing.dart';
import 'package:epoultry/core/presentation/components/gradient_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../../core/domain/models/error.dart';
import '../../../theme/colors.dart';
import '../../../core/presentation/components/loading_spinner.dart';

class ExtensionOfficer extends StatefulWidget {
  const ExtensionOfficer({Key? key}) : super(key: key);

  @override
  State<ExtensionOfficer> createState() => _ExtensionOfficerState();
}

class _ExtensionOfficerState extends State<ExtensionOfficer> {
  bool _obscurePassword = true;

  bool _obscureConfirmPassword = true;
  final firstName = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final lastName = TextEditingController();
  final idNumber = TextEditingController();
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
                Image.asset(
                  'assets/logo.png',
                  scale: 1.5,
                ),
                const SizedBox(
                  height: CustomSpacing.s1,
                ),
                Text(
                  'Register as an extension officer.',
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
                          keyboardType: TextInputType.text,
                          controller: idNumber,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'National ID is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "National ID",
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
                        TextFormField(
                          controller: password,
                          keyboardType: TextInputType.text,
                          obscureText: _obscurePassword,
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Password is required';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Password",
                              labelStyle: TextStyle(
                                  fontSize: 2.2.h,
                                  color: CustomColors.secondary),
                              suffixIcon: IconButton(
                                onPressed: _togglePasswordStatus,
                                icon: Icon(
                                    _obscurePassword
                                        ? PhosphorIcons.eye
                                        : PhosphorIcons.eyeSlash,
                                    color: CustomColors.secondary),
                              ),
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
                          controller: confirmPassword,
                          keyboardType: TextInputType.text,
                          obscureText: _obscureConfirmPassword,
                          validator: (String? value) {
                            if(value!.isEmpty){
                              return "Confirm password is required";
                            }

                            if (value != password.text) {
                              return "Passwords must match";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                              labelText: "Confirm Password",
                              labelStyle: TextStyle(
                                  fontSize: 2.2.h,
                                  color: CustomColors.secondary),
                              suffixIcon: IconButton(
                                onPressed: _togglePasswordConfirmStatus,
                                icon: Icon(
                                    _obscureConfirmPassword
                                        ? PhosphorIcons.eye
                                        : PhosphorIcons.eyeSlash,
                                    color: CustomColors.secondary),
                              ),
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
                const SizedBox(
                  height: CustomSpacing.s3,
                ),
                Mutation(
                  options: MutationOptions(
                    operationName: "RegisterExtensionOfficer",
                    document: gql(context.queries.registerExtensionOfficer()),
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
                            if (phoneNumber.text.startsWith('+254')) {
                              phoneNumber.text =
                                  phoneNumber.text.replaceFirst('+254', '0');
                            }
                            if (_formKey.currentState!.validate()) {
                              _registerButtonPressed(context, runMutation);
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
                            'SIGN UP',
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
    var phone = phoneNumber.text;

    if (phoneNumber.text.startsWith('0')) {
      phone = phoneNumber.text.replaceFirst('0', '');
    }
    if ((data != null)) {
      Get.to(() => OtpPage(
            route: "registerExtensionOfficer",
            phone: phone,
          ));
    }
  }

  Future<void> _registerButtonPressed(
      BuildContext context, RunMutation runMutation) async {
    runMutation(
      {
        "data": {
          'firstName': firstName.text,
          'phoneNumber': phoneNumber.text,
          "nationalId": idNumber.text,
          "lastName": lastName.text,
          "password": password.text
        }
      },
    );
  }
}
