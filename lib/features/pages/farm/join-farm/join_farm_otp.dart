import 'package:epoultry/core/graphql/query_document_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/data/models/error.dart';
import '../../../../core/theme/colors.dart';
import '../../../../core/theme/spacing.dart';
import '../../../../core/widgets/gradient_widget.dart';
import '../../../../core/widgets/loading_spinner.dart';
import '../../../../core/widgets/success_widget.dart';

class JoinFarmOtp extends StatelessWidget {
  JoinFarmOtp({Key? key}) : super(key: key);
  final pinController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              scale: 1,
            ),
            const SizedBox(
              height: CustomSpacing.s1,
            ),
            Text(
              'Join a Farm',
              style: TextStyle(fontSize: 3.h),
            ),
            const SizedBox(
              height: CustomSpacing.s2,
            ),
            SizedBox(
              width: 80.w,
              child: Text(
                'Get a 4 digit code from the farmer and dial it below',
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
                      controller: pinController,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: focusedPinTheme,
                      submittedPinTheme: submittedPinTheme,
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
                document: gql(context.queries.joinFarm()),
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
                      onPressed: () => _otpButtonPressed(context, runMutation),
                      style: ElevatedButton.styleFrom(
                          foregroundColor: CustomColors.background,
                          backgroundColor: Colors.transparent,
                          disabledForegroundColor:
                              Colors.transparent.withOpacity(0.38),
                          disabledBackgroundColor:
                              Colors.transparent.withOpacity(0.12),
                          shadowColor: Colors.transparent,
                          fixedSize: Size(100.w, 6.h)),
                      child: const Text('VERIFY CODE')),
                );
              },
            ),
            const SizedBox(
              height: CustomSpacing.s3,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onCompleted(data, BuildContext context) async {
    if (data != null) {
      Get.to(() => const SuccessWidget(
            message: 'You have successfully joined the farm',
            route: 'dashboard',
          ));
    }
  }

  Future<void> _otpButtonPressed(
      BuildContext context, RunMutation runMutation) async {
    runMutation(
      {'inviteCode': pinController.text},
    );
  }
}
