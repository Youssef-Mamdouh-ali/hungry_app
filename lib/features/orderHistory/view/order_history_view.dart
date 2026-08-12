import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hungry_app/core/constant/app_colors.dart';
import 'package:hungry_app/core/theme/app_text_style.dart';
import 'package:hungry_app/core/widgets/custom_elevated_button.dart';

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: List.generate(5, (index){return Card(
              margin: EdgeInsets.only(top: 20 , bottom: 5),
              elevation: 5,
              shadowColor: Colors.black,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/image 1.png",
                        width: 120,
                        height: 120,
                      ),
                      Gap(20),
                      Column(
                        children: [
                          Text(
                            "Cheeseburger",
                            style: AppTextStyle.black18W700,
                          ),
                          Text(
                            "\$ 10",
                            style: AppTextStyle.black18W700,
                          ),
                        ],
                      ),
                    ],
                  ),
                  CustomElevatedButton(
                    text: "Order Again",
                    onPressed: () {},
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                  ),
                ],
              ),
            );}),
          ),
        ),
      ),
    );
  }
}
