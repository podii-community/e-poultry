import 'dart:developer';

import 'package:epoultry/graphql/query_document_provider.dart';
import 'package:epoultry/widgets/gradient_widget.dart';
import 'package:epoultry/widgets/success_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

import '../../controllers/farm_controller.dart';
import '../../controllers/user_controller.dart';
import '../../data/models/error.dart';
import '../../graphql/graphql_config.dart';
import '../../theme/colors.dart';
import '../../theme/spacing.dart';
import '../../widgets/loading_spinner.dart';
import '../farm/join-farm/join_farm_page.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({Key? key, required this.route, required this.phone})
      : super(key: key);

  final String route;
  final String phone;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final _formKey = GlobalKey<FormState>();
  final pinController = TextEditingController();

  final FarmsController controller = Get.put(FarmsController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: CustomSpacing.s2),
        child: Center(
          child: SingleChildScrollView(
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
                  'Verify Phone Number',
                  style: TextStyle(fontSize: 3.h),
                ),
                const SizedBox(
                  height: CustomSpacing.s2,
                ),
                SizedBox(
                  width: 80.w,
                  child: Text(
                    'A 6-digit code has been sent to +254${widget.phone}',
                    style: TextStyle(fontSize: 2.h),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: CustomSpacing.s3,
                ),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Pinput(
                          length: 6,
                          controller: pinController,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          submittedPinTheme: submittedPinTheme,
                          onCompleted: (pin) => log(pin),
                        ),
                        const SizedBox(
                          height: CustomSpacing.s3,
                        ),
                      ],
                    )),
                const SizedBox(
                  height: CustomSpacing.s3,
                ),
                Mutation(
                  options: MutationOptions(
                    operationName: "VerifyOtp",
                    document: gql(context.queries.verifyOtp()),
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
                              _otpButtonPressed(context, runMutation),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              onSurface: Colors.transparent,
                              shadowColor: Colors.transparent,
                              onPrimary: CustomColors.background,
                              fixedSize: Size(100.w, 6.h)),
                          child: Text(
                            'VERIFY PHONE NUMBER',
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
                      text: "Didnt get the code? ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 1.8.h,
                      ),
                      children: [
                        TextSpan(
                            text: "RESEND",
                            style: TextStyle(
                                color: CustomColors.secondary,
                                fontSize: 1.8.h,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.underline),
                            recognizer: TapGestureRecognizer()..onTap = () {})
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onCompleted(data, BuildContext context) async {
    final box = Hive.box('appData');

    if ((data['verifyOtp']['apiKey']).toString().isNotEmpty) {
      box.put('name',
          "${data['verifyOtp']['user']['firstName']} ${data['verifyOtp']['user']['lastName']}");
      box.put('phone', data['verifyOtp']['user']['phoneNumber']);

      if (data['verifyOtp']['user']['farmer'] == null) {
        box.put('role', 'manager');
      } else {
        box.put('role', 'farmer');
      }

      context.cacheToken(data['verifyOtp']['apiKey']);
      box.put('token', data['verifyOtp']['apiKey']);
      GraphQLConfiguration.setToken(data['verifyOtp']['apiKey']);

      final name = data['verifyOtp']['user']["firstName"] +
          " " +
          data['verifyOtp']['user']["lastName"];

      userController.updateName(name);
      userController.updatePhone(data['verifyOtp']['user']['phoneNumber']);

      if (data['verifyOtp']['user']['managingFarms'].isNotEmpty ||
          data['verifyOtp']['user']['ownedFarms'].isNotEmpty) {
        List managingFarms = data['verifyOtp']['user']!["managingFarms"];
        List ownedFarms = data['verifyOtp']['user']!["ownedFarms"];

        List farms = managingFarms + ownedFarms;

        controller.updateFarms(farms);
        controller.updateFarm(farms[0]);
        controller.updateBatches(farms[0]['batches']);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SuccessWidget(
                      message: 'Your phone number has been verified',
                      route: widget.route,
                    )));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const JoinFarmPage()));
      }
    }
  }

  Future<void> _otpButtonPressed(
      BuildContext context, RunMutation runMutation) async {
    runMutation(
      {'phoneNumber': widget.phone, 'otpCode': pinController.text},
    );
  }
}
