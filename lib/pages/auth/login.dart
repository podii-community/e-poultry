import 'dart:developer';

import 'package:epoultry/pages/auth/registration.dart';
import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/widgets/gradient_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:sizer/sizer.dart';

import '../../data/models/error.dart';
import '../../theme/colors.dart';
import '../../theme/spacing.dart';
import '../../widgets/loading_spinner.dart';
import 'otp_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final phoneNumber = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              scale: 1.5,
            ),
            const SizedBox(
              height: CustomSpacing.s1,
            ),
            Text(
              'Log In',
              style: TextStyle(fontSize: 3.h),
            ),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: phoneNumber,
                      keyboardType: TextInputType.phone,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone Number is required';
                        }
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
                operationName: "RequestLoginOtp",
                document: gql(context.queries.login()),
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
                          _loginButtonPressed(context, runMutation);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.transparent,
                          onSurface: Colors.transparent,
                          shadowColor: Colors.transparent,
                          onPrimary: CustomColors.background,
                          fixedSize: Size(100.w, 6.h)),
                      child: Text(
                        'LOG IN',
                        style: TextStyle(
                          fontSize: 1.8.h,
                        ),
                      )),
                );
              },
            ),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
            RichText(
              text: TextSpan(
                  text: "Create an account? ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 1.8.h,
                  ),
                  children: [
                    TextSpan(
                        text: "SIGN UP",
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
                                        const RegistrationPage()));
                          })
                  ]),
            )
          ],
        ),
      ),
    );
  }

  void _onCompleted(data, BuildContext context) {
    /// If they do, move to home page. If not, take them to select artist page for them to select artists.
    ///;

    var phone = phoneNumber.text.replaceFirst('0', '');

    if (data["requestLoginOtp"]) {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => OtpPage(route: "login", phone: phone)));
    }
  }

  Future<void> _loginButtonPressed(
      BuildContext context, RunMutation runMutation) async {
    runMutation(
      {
        'phoneNumber': phoneNumber.text,
      },
    );
  }
}
