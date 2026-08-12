import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry_app/core/constant/app_colors.dart';
import 'package:hungry_app/core/di/injection_container.dart';
import 'package:hungry_app/core/router/app_routes.dart';
import 'package:hungry_app/core/theme/app_text_style.dart';
import 'package:hungry_app/core/utils/app_validators.dart';
import 'package:hungry_app/core/widgets/custom_elevated_button.dart';
import 'package:hungry_app/core/widgets/custom_text_form_field.dart';
import 'package:hungry_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:hungry_app/features/auth/presentation/cubit/auth_state.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool obscurePassword = true;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();


  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /// logo
              Gap(70),
              SvgPicture.asset("assets/logo.svg", color: AppColors.primary),
              Gap(100),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          CustomTextFormField(
                            controller: _name,
                            validator: AppValidators.name,

                            hint: "Name",
                            prefixIcon: Icon(
                              Icons.person,
                              color: AppColors.white,
                            ),
                          ),
                          Gap(20),
                          CustomTextFormField(
                            controller: _email,
                            validator: AppValidators.email,
                            hint: "Email",
                            prefixIcon: Icon(
                              Icons.email,
                              color: AppColors.white,
                            ),
                          ),
                          Gap(20),
                        CustomTextFormField(
                          controller: _password,
                          validator: AppValidators.password,
                          obscureText: obscurePassword,
                          hint: "Password",
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: AppColors.white,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscurePassword = !obscurePassword;
                              });
                            },
                            icon: Icon(
                              obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                          Gap(30),
                          BlocConsumer<AuthCubit, AuthState>(
                            listener: (context, state) {
                              if (state is AuthSuccess) {
                                context.go(AppRoutes.layout);
                              }

                              if (state is AuthFailure) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(state.message),
                                  ),
                                );
                              }
                            },

                            builder: (context, state) {
                              return CustomElevatedButton(
                                text: state is AuthLoading
                                    ? "Creating Account..."
                                    : "Sign Up",
                                onPressed: state is AuthLoading
                                    ? null
                                    : () {
                                  if (formKey.currentState!.validate()) {
                                    context.read<AuthCubit>().register(
                                      name: _name.text.trim(),
                                      email: _email.text.trim(),
                                      password: _password.text,
                                    );
                                  }
                                },
                              );
                            },
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account?",
                                style: AppTextStyle.white16Regular,
                              ),
                              TextButton(
                                onPressed: () {
                                  context.go(AppRoutes.login);
                                },
                                child: Text(
                                  "Login",
                                  style: AppTextStyle.underLineWhite14Regular,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
