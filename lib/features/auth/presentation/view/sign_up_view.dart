import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import 'package:hungry_app/core/constant/app_colors.dart';
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

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool obscurePassword = true;

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
          child: LayoutBuilder(
            builder: (context, constraints) {
              final double width = constraints.maxWidth;
              final double height = constraints.maxHeight;

              // Responsive values
              final bool isMobile = width < 600;

              final double logoWidth = width < 360
                  ? 160
                  : width < 400
                  ? 220
                  : 250;

              final double logoTopSpacing = isMobile
                  ? height * 0.08
                  : height * 0.06;

              final double logoBottomSpacing = isMobile
                  ? height * 0.08
                  : height * 0.06;

              final double horizontalPadding = isMobile ? 16 : 30;

              final double verticalPadding = isMobile ? 40 : 30;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  /// Logo
                  Padding(
                    padding: EdgeInsets.only(
                      top: logoTopSpacing,
                      bottom: logoBottomSpacing,
                    ),
                    child: SizedBox(
                      width: logoWidth,
                      child: SvgPicture.asset(
                        "assets/logo.svg",
                        colorFilter: const ColorFilter.mode(
                          AppColors.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.r),
                          topLeft: Radius.circular(30.r),
                        ),
                      ),
                      child: SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: horizontalPadding,
                          vertical: verticalPadding,
                        ),
                        child: Form(
                          key: formKey,
                          child: Column(
                            children: [
                             /// Name
                              CustomTextFormField(
                                controller: _name,
                                validator: AppValidators.name,
                                hint: "Name",
                                prefixIcon: const Icon(
                                  Icons.person,
                                  color: AppColors.white,
                                ),
                              ),

                              const Gap(20),

                              /// Email
                              CustomTextFormField(
                                controller: _email,
                                validator: AppValidators.email,
                                hint: "Email",
                                prefixIcon: const Icon(
                                  Icons.email,
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
                                prefixIcon: const Icon(
                                  Icons.lock,
                                  color: AppColors.white,
                                ),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      obscurePassword =
                                      !obscurePassword;
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

                              const Gap(25),

                              /// Sign Up Button
                              BlocConsumer<AuthCubit, AuthState>(
                                listener: (context, state) {
                                  if (state is AuthSuccess) {
                                    context.go(
                                      AppRoutes.layout,
                                    );
                                  }

                                  if (state is AuthFailure) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(
                                      SnackBar(
                                        content: Text(
                                          state.message,
                                        ),
                                      ),
                                    );
                                  }
                                },
                                builder: (context, state) {
                                  return SizedBox(
                                    width: double.infinity,
                                    child: CustomElevatedButton(
                                      text: state is AuthLoading
                                          ? "Creating Account..."
                                          : "Sign Up",
                                      onPressed:
                                      state is AuthLoading
                                          ? null
                                          : () {
                                        if (formKey
                                            .currentState!
                                            .validate()) {
                                          context
                                              .read<AuthCubit>()
                                              .register(
                                            name: _name
                                                .text
                                                .trim(),
                                            email: _email
                                                .text
                                                .trim(),
                                            password:
                                            _password
                                                .text,
                                          );
                                        }
                                      },
                                    ),
                                  );
                                },
                              ),

                              const Gap(10),

                              /// Login
                              Wrap(
                                alignment: WrapAlignment.center,
                                crossAxisAlignment:
                                WrapCrossAlignment.center,
                                children: [
                                  const Text(
                                    "Already have an account?",
                                    style:
                                    AppTextStyle.white16Regular,
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      context.go(
                                        AppRoutes.login,
                                      );
                                    },
                                    child: Text(
                                      "Login",
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
              );
            },
          ),
        ),
      ),
    );
  }
}