import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry_app/core/constant/app_colors.dart';
import 'package:hungry_app/core/theme/app_text_style.dart';
import 'package:hungry_app/core/widgets/custom_elevated_button.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 400,
      width: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadiusGeometry.circular(12),
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 10, spreadRadius: 5),
        ],
      ),
      child: Column(
        children: [
          Icon(Icons.check_circle, color: AppColors.primary, size: 90),
          Gap(20),
          Text(
            "Success !",
            style: AppTextStyle.primary30Bold,
          ),
          Gap(20),
          Text(
            textAlign: TextAlign.center,
            "Your payment was successful. A receipt for this purchase has been sent to your email.",
            style: AppTextStyle.grey13Regular,
          ),
          Gap(45),
          CustomElevatedButton(
            text: "Go Back",
            onPressed: () {
              context.pop();
            },
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            width: 170,
            height: 50,
          ),
        ],
      ),
    );
  }
}
