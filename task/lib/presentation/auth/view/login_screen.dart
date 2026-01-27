import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../cubit/auth_cubit.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final bool isKeyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 60.h),
                Center(
                  child: Image.asset(
                    Assets.images.logo.path,
                    height: 80.h,
                    width: 80.h,
                  ),
                ),
                SizedBox(height: 27.h),

                Text("Create your account", style: theme.textTheme.titleLarge),

                SizedBox(height: 16.h),

                CustomTextFormField(
                  hintText: 'Enter Phone',
                  controller: emailController,
                  textInputType: TextInputType.emailAddress,
                  validator: (email) => validateEmail(email!),
                ),

                SizedBox(height: 28.h),

                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthError) {
                      context.showSnackBar(state.message);
                    } else if (state is AuthSuccess) {
                      context.pushNamed(
                        AppRoutes.otpVerify,
                        extra: state.message,
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomElevatedButton(
                      isLoading: state is AuthLoading,
                      text: 'Continue',
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthCubit>().loginRequest(
                            email: emailController.text.trim(),
                          );
                        }
                      },
                    );
                  },
                ),
                SizedBox(height: 28.h),

                Row(
                  children: [
                    Expanded(child: Divider(color: appTheme.white)),
                    SizedBox(width: 9.h),
                    Text("Or", style: theme.textTheme.titleMedium),
                    SizedBox(width: 9.h),
                    Expanded(child: Divider(color: appTheme.white)),
                  ],
                ),
                SizedBox(height: 20.h),

                Container(
                  padding: EdgeInsets.symmetric(vertical: 9.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: appTheme.white),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(Assets.images.imgGoogle.path, height: 25),
                      SizedBox(width: 8),
                      Text(
                        context.translate.continueGoogle,
                        style: theme.textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),

                Center(
                  child: Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      children: [
                        TextSpan(
                          text: "By signing up, you agree to our",
                          style: theme.textTheme.bodyMedium,
                        ),
                        TextSpan(
                          text: "\nTerms & Privacy Policy",
                          style: theme.textTheme.bodyMedium!.copyWith(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.white,
                          ),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
