import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart' show PinTheme, Pinput;
import 'package:task/core/app_export.dart';
import 'package:task/data/models/common_model.dart';
import 'package:task/l10n/app_localizations.dart';
import 'package:task/presentation/auth/cubit/otp_timer_cubit.dart';
import 'package:task/presentation/auth/cubit/otp_timer_state.dart';

import '../../../data/repositories/auth_repository_impl.dart';
import '../cubit/auth_cubit.dart';

class OtpVerifyScreen extends StatelessWidget {
  final String phone;
  OtpVerifyScreen({super.key, required this.phone});
  final otpController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 150.h),
                Text(AppLocalizations.of(context)!.enterCode, style: theme.textTheme.titleLarge),
                SizedBox(height: 4.h),

                Text.rich(
                  textAlign: TextAlign.center,
                  TextSpan(
                    children: [
                      TextSpan(
                        text: " $phone",
                        style: theme.textTheme.bodyMedium,
                        recognizer: TapGestureRecognizer()..onTap = () {},
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 24.h),
                Center(
                  child: Pinput(
                    controller: otpController,
                    autofocus: false,
                    length: 6,
                    cursor: Container(height: 22, width: 2, color: appTheme.white),
                    defaultPinTheme: PinTheme(
                      margin: const EdgeInsets.symmetric(horizontal: 2),
                      width: 48.h,
                      height: 48.h,
                      textStyle: TextStyle(fontSize: 22.fSize, color: appTheme.white),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    focusedPinTheme: PinTheme(
                      width: 48.h,
                      height: 48.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    validator: (value) => validateField(value: value!, title: 'otp'),
                    onCompleted: (pin) async {
                      otpController.text = pin;
                      context.read<AuthCubit>().verifyOtp(
                        email: extractEmailFromMessage(phone) ?? '',
                        otp: otpController.text.trim(),
                      );
                    },
                    errorTextStyle: TextStyle(fontSize: 15.fSize, color: appTheme.errorRed),
                  ),
                ),
                SizedBox(height: 24.h),
                Center(
                  child: Text(
                    AppLocalizations.of(context)!.didNotReceive,
                    style: Theme.of(context).textTheme.bodySmall!,
                  ),
                ),
                BlocProvider(
                  create: (context) => OtpTimerCubit()..startTimer(),
                  child: BlocBuilder<OtpTimerCubit, OtpTimerState>(
                    builder: (context, state) {
                      final isTimerRunning = state is OtpTimerInProgress;
                      return Center(
                        child: TextButton(
                          onPressed: isTimerRunning
                              ? null
                              : () async {
                                  otpController.clear();
                                  CommonModel result = await AuthRepositoryImpl().login(
                                    extractEmailFromMessage(phone) ?? '',
                                  );
                                  context.showSnackBar(result.message);
                                  context.read<OtpTimerCubit>().startTimer();
                                },
                          child: Text(
                            isTimerRunning ? 'Resend in ${state.duration}s' : AppLocalizations.of(context)!.resendCode,
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: isTimerRunning ? Colors.grey : appTheme.primary,
                              fontSize: 16.fSize,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 28.h),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthError) {
                      context.showSnackBar(state.message);
                    } else if (state is AuthSuccess) {
                      if (state.isNewUser ?? false) {
                        //context.goNamed(AppRoutes.bottomBar);
                      } else {
                        // context.goNamed(AppRoutes.editProfile, extra: true);
                      }
                    }
                  },
                  builder: (context, state) {
                    return CustomElevatedButton(
                      isLoading: state is AuthLoading,
                      text: context.translate.confirmContinueTxt,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthCubit>().verifyOtp(
                            email: extractEmailFromMessage(phone) ?? '',
                            otp: otpController.text.trim(),
                          );
                        }
                      },
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

  String? extractEmailFromMessage(String message) {
    // Regular expression pattern for email detection
    final emailRegex = RegExp(r'[\w\.-]+@[\w\.-]+\.\w+');

    // Try to find the first match
    final match = emailRegex.firstMatch(message);

    // Return the found email, or null if not found
    return match?.group(0);
  }
}
