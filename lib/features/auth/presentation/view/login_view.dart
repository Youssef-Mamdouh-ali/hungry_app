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

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool obscurePassword = true;

  @override
  void dispose() {
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
        backgroundColor: Colors.white,

        body: SafeArea(
          child: Column(
            children: [
              /// Logo
              const Gap(70),

              SvgPicture.asset(
                "assets/logo.svg",
                colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
              ),

              const Gap(70),

              /// Form Section
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 40,
                  ),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),

                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,

                      child: Column(
                        children: [
                          /// Email
                          CustomTextFormField(
                            controller: _email,
                            validator: AppValidators.email,
                            hint: "Email",
                            keyboardType: TextInputType.emailAddress,
                            prefixIcon: const Icon(
                              Icons.email_outlined,
                              color: AppColors.white,
                            ),
                          ),

                          const Gap(20),

                          /// Password
                          CustomTextFormField(
                            controller: _password,
                            validator: AppValidators.password,
                            obscureText: obscurePassword,
                            hint: "Password",
                            keyboardType: TextInputType.visiblePassword,
                            prefixIcon: const Icon(
                              Icons.lock_outline,
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

                          const Gap(20),

                          /// Login
                          BlocConsumer<AuthCubit, AuthState>(
                            listener: (context, state) {
                              if (state is AuthSuccess) {
                                context.go(AppRoutes.layout);
                              }

                              if (state is AuthFailure) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(
                                  SnackBar(
                                    content: Text(state.message),
                                  ),
                                );
                              }
                            },

                            builder: (context, state) {
                              return CustomElevatedButton(
                                text: state is AuthLoading
                                    ? "Logging in..."
                                    : "Login",

                                onPressed: state is AuthLoading
                                    ? null
                                    : () {
                                  if (formKey.currentState!
                                      .validate()) {
                                    context
                                        .read<AuthCubit>()
                                        .login(
                                      email: _email.text.trim(),
                                      password: _password.text,
                                    );
                                  }
                                },

                                backgroundColor: Colors.white,
                              );
                            },
                          ),

                          const Gap(10),

                          /// Sign Up
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Don't have an account?",
                                style: AppTextStyle.white16Regular,
                              ),

                              TextButton(
                                onPressed: () {
                                  context.go(AppRoutes.signUp);
                                },
                                child: Text(
                                  "Sign Up",
                                  style: AppTextStyle
                                      .underLineWhite14Regular,
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