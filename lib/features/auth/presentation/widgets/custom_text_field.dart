import 'package:flutter/material.dart';
import 'package:hungry_app/core/constant/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;

  final TextEditingController? controller;

  final bool obscureText;

  final Widget? suffixIcon;

  final TextInputType keyboardType;

  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,

    required this.label,

    this.controller,

    this.obscureText = false,

    this.suffixIcon,

    this.keyboardType = TextInputType.text,

    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,

      obscureText: obscureText,

      keyboardType: keyboardType,

      onChanged: onChanged,


      style: const TextStyle(
        color: Colors.white,
        fontSize: 15,
        fontWeight: FontWeight.w600,
      ),

      decoration: InputDecoration(
        suffixIcon: suffixIcon,

        filled: true,

        fillColor: AppColors.primary,

        labelText: label,

        labelStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),

        floatingLabelBehavior:
        FloatingLabelBehavior.always,


        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),


        enabledBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(18),

          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),

        ),


        focusedBorder: OutlineInputBorder(

          borderRadius: BorderRadius.circular(18),

          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 2,
          ),

        ),

      ),
    );
  }
}
