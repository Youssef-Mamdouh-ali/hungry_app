import 'package:flutter/material.dart';
import 'package:hungry_app/core/theme/app_text_style.dart';
import 'package:hungry_app/features/home/domain/entities/product_entity.dart';

class CustomProductWidget extends StatelessWidget {
  final ProductEntity product;

  const CustomProductWidget({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      width: 185,
      height: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(2, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Image
          Center(
            child: SizedBox(
              width: 120,
              height: 120,
              child: Image.asset(
                product.image,
                fit: BoxFit.contain,
              ),
            ),
          ),

          /// Name
          Text(
            product.name,
            style: AppTextStyle.black16W700,
          ),

          /// Description
          Text(
            product.description,
            style: AppTextStyle.black14Regular,
          ),

          /// Rating
          Text(
            "⭐${product.rating}",
          ),
        ],
      ),
    );
  }
}