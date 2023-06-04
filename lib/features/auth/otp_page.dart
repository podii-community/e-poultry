import 'dart:developer';

import 'package:epoultry/core/graphql/query_document_provider.dart';
import 'package:epoultry/core/presentation/components/gradient_widget.dart';
import 'package:epoultry/core/presentation/components/success_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive/hive.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

import '../../core/presentation/controllers/farm_controller.dart';
import '../../core/presentation/controllers/user_controller.dart';
import '../../core/domain/models/error.dart';
import '../../core/graphql/graphql_config.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import '../../core/presentation/components/loading_spinner.dart';
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

  final controller = Get.find<FarmsController>();
  final userController = Get.find<UserController>();

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
                              foregroundColor: CustomColors.background,
                              backgroundColor: Colors.transparent,
                              disabledForegroundColor:
                                  Colors.transparent.withOpacity(0.38),
                              disabledBackgroundColor:
                                  Colors.transparent.withOpacity(0.12),
                              shadowColor: Colors.transparent,
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
      context.cacheToken(data['verifyOtp']['apiKey']);
      box.put('token', data['verifyOtp']['apiKey']);
      GraphQLConfiguration.setToken(data['verifyOtp']['apiKey']);

      if (data['verifyOtp']['user']['managingFarms'].isNotEmpty ||
          data['verifyOtp']['user'].isNotEmpty ||
          data['verifyOtp']['user']['ownedFarms'].isNotEmpty) {
        // List managingFarms = data['verifyOtp']['user']!["managingFarms"];
        // List ownedFarms = data['verifyOtp']['user']!["ownedFarms"];

        // List farms = managingFarms + ownedFarms;

        // controller.updateFarms(farms);
        // log("OTP>>>>${controller.farms.value}");

        // controller.farm.value = farms[0];
        // controller.selectedFarmId.value = farms[0]['id'];
        // controller.updateBatches(farms[0]['batches']);
        final role = data['verifyOtp']['user']["role"];
        final phone = data['verifyOtp']['user']["phoneNumber"];
        String route = widget.route;
        box.put('tokenRole', role);
        box.put('tokenPhone', phone);

        if (role == "FARMER") route = "farmer";
        if (role == "FARM_MABAGER") route = 'farm_manager';
        if (data['verifyOtp'] != null && data['verifyOtp']['user'] != null) {
          final name = data['verifyOtp']['user']["firstName"] +
              " " +
              data['verifyOtp']['user']["lastName"];

          userController.updateName(name);
          userController.updatePhone(data['verifyOtp']['user']['phoneNumber']);

          if (data['verifyOtp']['user']["extensionOfficer"] != null) {
            // userController.updateLoc(data['verifyOtp']['user']
            //     ["extensionOfficer"]['address']['county']);
            // userController.updateId(data['verifyOtp']['user']["vetOfficer"]['nationalId']);
            final id = data['verifyOtp']['user']['nationalId'];
            userController.updateId(id);
            final extApproved =
                data['verifyOtp']['user']["extensionOfficer"]["dateApproved"];
            box.put('extApproved', extApproved);

            if (role == "EXTENSION_OFFICER" && extApproved != null) {
              route = 'extension';
            } else {
              route = 'ext';
            }
          }
          if (data['verifyOtp']['user']["vetOfficer"] != null) {
            // userController.updateLoc(
            //     data['verifyOtp']['user']["vetOfficer"]['address']['county']);
            // userController.updateId(data['verifyOtp']['user']["vetOfficer"]['nationalId']);
            // userController.updateVetNumber(
            //     data['verifyOtp']['user']["vetOfficer"]["vetNumber"]);
            final vetApproved =
                data['verifyOtp']['user']["vetOfficer"]["dateApproved"];
            box.put('vetApproved', vetApproved);
            userController.updateId(
                data['verifyOtp']['user']["vetOfficer"]['nationalId']);
            userController.updateVetNumber(
                data['verifyOtp']['user']["vetOfficer"]["vetNumber"]);
            if (role == "VET_OFFICER" && vetApproved != null) {
              route = 'vet';
            } else {
              route = 'veterinary';
            }
          }
        }

        Get.offAll(() => SuccessWidget(
              message: 'Your phone number has been verified',
              route: route,
            ));
      } else {
        Get.to(() => const JoinFarmPage());
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
