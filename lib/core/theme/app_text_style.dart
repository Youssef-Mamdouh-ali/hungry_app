import 'package:flutter/material.dart';
import 'package:hungry_app/core/constant/app_colors.dart';

abstract class AppTextStyle {
  static const TextStyle white16Regular = TextStyle(
    color: AppColors.white,
    fontSize: 16,
  );
  static const TextStyle black20Bold = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
    fontSize: 20,
  );
  static const TextStyle black20W700 = TextStyle(
    fontWeight: FontWeight.w700,
    color: Colors.black,
    fontSize: 20,
  );
  static const TextStyle white18Bold = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    fontSize: 18,
  );
  static const TextStyle grey16Regular = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 16,
    color: Colors.grey,
  );
  static const TextStyle grey13Regular = TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 13,
    color: Colors.grey,
  );
  static const TextStyle primary30Bold = TextStyle(
    color: AppColors.primary,
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle white20Bold = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.white,
    fontSize: 20,
  );
  static const TextStyle black14Regular = TextStyle(
    color:  Colors.black,
    fontSize: 14,
  );
  static const TextStyle white12W600 = TextStyle(
    color: Colors.white,
    fontSize: 12,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle white14Regular = TextStyle(
    color:  AppColors.white,
    fontSize: 14,
  );
  static const TextStyle black18W700 = TextStyle(
    color:  Colors.black,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle black16W700 = TextStyle(
    color:  Colors.black,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle black24W700 = TextStyle(
    color:  Colors.black,
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle underLineWhite14Regular = TextStyle(
    color: AppColors.white,
    fontSize: 14,
    decoration: TextDecoration.underline,
    decorationColor: AppColors.white,
  );
}
