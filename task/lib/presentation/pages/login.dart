import 'package:flutter/material.dart';
import 'package:task/core/app_export.dart';
import 'package:task/domain/usecases/auth_usecases.dart';
import 'package:task/presentation/cubit/theme_cubit.dart';
import 'package:task/presentation/cubit/auth/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6),
            onPressed: () {
              context.read<ThemeCubit>().toggleTheme();
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text('Welcome back', style: context.textTheme.titleLarge),
                SizedBox(height: 22.v),
                Text('Email', style: context.textTheme.bodyMedium),
                SizedBox(height: 6.v),
                CustomTextFormField(
                  controller: _emailController,
                  hintText: 'Email',
                  validator: (email) => validateEmail(email ?? ""),
                ),
                SizedBox(height: 12.v),
                Text('Password', style: context.textTheme.bodyMedium),
                SizedBox(height: 6.v),
                CustomTextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  hintText: 'Password',
                  suffix: Icon(Icons.visibility_off),
                ),

                SizedBox(height: 24.v),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthFailure) {
                      context.showSnackBar(state.failure.message);
                    } else if (state is AuthSuccess) {
                      context.showSnackBar(state.message);
                      context.pushNamed(AppRoutes.userList);
                    }
                  },
                  builder: (context, state) {
                    return CustomElevatedButton(
                      isLoading: state is AuthLoading,
                      text: 'Login',
                      onPressed: () {
                        if (!_formKey.currentState!.validate()) {
                          return;
                        }
                        LoginParams params = LoginParams(
                          email: _emailController.text,
                          password: _passwordController.text,
                        );
                        context.read<AuthCubit>().login(params);
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
}
