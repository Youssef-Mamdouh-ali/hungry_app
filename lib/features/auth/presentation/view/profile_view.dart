import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'package:hungry_app/core/constant/app_colors.dart';
import 'package:hungry_app/core/router/app_routes.dart';
import 'package:hungry_app/core/theme/app_text_style.dart';
import 'package:hungry_app/core/widgets/custom_elevated_button.dart';
import 'package:hungry_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:hungry_app/features/auth/presentation/cubit/auth_state.dart';
import 'package:hungry_app/features/auth/presentation/widgets/custom_text_field.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _delivery = TextEditingController();

  @override
  void initState() {
    super.initState();

    final state = context.read<AuthCubit>().state;

    if (state is AuthSuccess) {
      _name.text = state.user.name ?? '';
      _email.text = state.user.email;
    }

    _delivery.text = "Cairo-N.C";
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _delivery.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // App Bar
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: AppTextStyle.black20Bold,
        ),
      ),

      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double width = constraints.maxWidth;
            final double height = constraints.maxHeight;

            // Responsive values

            final bool isSmallMobile = width < 360;
            final bool isLargeMobile = width >= 400;

            final double profileImageRadius = isSmallMobile
                ? 45
                : isLargeMobile
                ? 60
                : 55;

            final double horizontalPadding = isSmallMobile
                ? 12
                : 16;

            final double cardPadding = isSmallMobile
                ? 18
                : 20;

            final double sectionSpacing = isSmallMobile
                ? 20
                : 25;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 16,
              ),
              child: Column(
                children: [
                  /// Profile Image
                  CircleAvatar(
                    radius: profileImageRadius,
                    backgroundImage: const AssetImage(
                      "assets/images/spider.jpg",
                    ),
                  ),

                  Gap(sectionSpacing),

                  /// Personal Information
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(cardPadding),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(25.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.08),
                          blurRadius: 20.r,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        const Text(
                          "Personal Information",
                          style: AppTextStyle.white18Bold,
                        ),

                        Gap(sectionSpacing),

                        /// Name
                        CustomTextField(
                          controller: _name,
                          label: "Name",
                        ),

                        Gap(sectionSpacing),

                        /// Email
                        CustomTextField(
                          controller: _email,
                          label: "Email",
                        ),

                        Gap(sectionSpacing),

                        /// Address
                        CustomTextField(
                          controller: _delivery,
                          label: "Address",
                        ),
                      ],
                    ),
                  ),

                  Gap(sectionSpacing),

                  Divider(
                    color: AppColors.primary.withOpacity(0.3),
                  ),

                  Gap(sectionSpacing),

                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Payment Method",
                      style: AppTextStyle.black20Bold,
                    ),
                  ),

                  Gap(sectionSpacing),

                  /// Payment Card
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(cardPadding),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18.r),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.2),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10.r,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        /// Visa Image
                        Container(
                          width: isSmallMobile ? 55 : 65,
                          height: isSmallMobile ? 40 : 45,
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade100,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Image.asset(
                            "assets/icons/visa.png",
                            fit: BoxFit.contain,
                          ),
                        ),

                        const Gap(15),

                        /// Card Information
                        const Expanded(
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Visa Card",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),

                              Gap(5),

                              Text(
                                "**** **** **** 0505",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Icon(
                          Icons.check_circle,
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                  ),

                  Gap(sectionSpacing),

                  /// Save Changes
                  SizedBox(
                    width: double.infinity,
                    child: CustomElevatedButton(
                      text: "Save Changes",
                      onPressed: () {},
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ),

                  const Gap(20),

                  /// Logout
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthLogoutSuccess) {
                        context.go(AppRoutes.login);
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
                      return SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                          text: state is AuthLoading
                              ? "Logging out..."
                              : "Logout",
                          onPressed: state is AuthLoading
                              ? null
                              : () {
                            context
                                .read<AuthCubit>()
                                .logout();
                          },
                        ),
                      );
                    },
                  ),

                  const Gap(20),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}