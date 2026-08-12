import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
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

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Profile",
          style: AppTextStyle.black20Bold,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          children: [

            /// Profile Image
            const CircleAvatar(
              radius: 55,
              backgroundImage: AssetImage(
                "assets/images/spider.jpg",
              ),
            ),

            const Gap(12),

            /// User Name
            Text(
              _name.text,
              style: AppTextStyle.black20Bold,
            ),

            const Gap(30),

            /// Personal Information
            Container(
              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(25),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
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

                  const Gap(20),

                  /// Name
                  CustomTextField(
                    controller: _name,
                    label: "Name",
                  ),

                  const Gap(20),

                  /// Email
                  CustomTextField(
                    controller: _email,
                    label: "Email",
                  ),

                  const Gap(20),

                  /// Address
                  CustomTextField(
                    controller: _delivery,
                    label: "Address",
                  ),
                ],
              ),
            ),

            const Gap(30),

            Divider(
              color: AppColors.primary.withOpacity(0.3),
            ),

            const Gap(20),

            /// Payment Method
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Payment Method",
                style: AppTextStyle.black20Bold,
              ),
            ),

            const Gap(15),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),

                border: Border.all(
                  color: AppColors.primary.withOpacity(0.2),
                ),

                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),

              child: Row(
                children: [

                  Container(
                    width: 60,
                    height: 40,
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

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
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

                  Icon(
                    Icons.check_circle,
                    color: AppColors.primary,
                  ),
                ],
              ),
            ),

            const Gap(30),

            /// Save Changes
            CustomElevatedButton(
              text: "Save Changes",
              onPressed: () {
                // هنربطها بعدين بتحديث بيانات المستخدم
              },
              backgroundColor: AppColors.primary,
              foregroundColor: Colors.white,
            ),

            const Gap(15),

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
                return CustomElevatedButton(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,

                  text: state is AuthLoading
                      ? "Logging out..."
                      : "Logout",

                  onPressed: state is AuthLoading
                      ? null
                      : () {
                    context.read<AuthCubit>().logout();
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}