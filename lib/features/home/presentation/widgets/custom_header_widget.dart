import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hungry_app/core/constant/app_colors.dart';
import 'package:hungry_app/core/theme/app_text_style.dart';
class CustomHeaderWidget extends StatelessWidget {
  const CustomHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              "assets/logo.svg",
              width: 200,
              colorFilter: ColorFilter.mode(
                AppColors.primary,
                BlendMode.srcIn,
              ),
            ),
            Text("Welcome back, Spider Man" ,style: AppTextStyle.grey13Regular),
          ],
        ),

        Spacer(),
        Container(
          width: 50,
          height: 50,
          clipBehavior: Clip.antiAlias,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Image.asset(
            "assets/images/spider.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ],
    );
  }
}
