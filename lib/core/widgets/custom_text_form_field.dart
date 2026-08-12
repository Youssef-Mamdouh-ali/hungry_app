import 'package:flutter/material.dart';
import 'package:hungry_app/core/constant/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final bool obscureText;
  final TextInputType keyboardType;
  final String hint;
  final Color? hintColor;
  final TextEditingController controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color? borderColor;
  final bool filled;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hint,
    this.obscureText = false,
    this.keyboardType = TextInputType.emailAddress,
    this.prefixIcon,
    this.suffixIcon,
    this.hintColor,
    this.borderColor,
    this.filled = false,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

      onChanged: onChanged,

      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },

      obscureText: obscureText,
      keyboardType: keyboardType,
      cursorColor: AppColors.white,
      validator: validator,

      decoration: InputDecoration(
        fillColor: AppColors.primary,
        filled: filled,

        hintText: hint,
        hintStyle: TextStyle(
          color: hintColor ?? AppColors.white,
        ),

        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: borderColor ?? AppColors.white,
          ),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: borderColor ?? AppColors.white,
          ),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            color: borderColor ?? AppColors.white,
          ),
        ),
      ),
    );
  }
}