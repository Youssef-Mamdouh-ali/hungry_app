import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hungry_app/core/theme/app_text_style.dart';
 class OrderDetailsWidget extends StatelessWidget {
   final String order , taxes , fees , total ;
   const OrderDetailsWidget({super.key, required this.order, required this.taxes, required this.fees, required this.total});

   @override
   Widget build(BuildContext context) {
     return Padding(
       padding: const EdgeInsets.symmetric(horizontal: 12.0),
       child: Column(
         children: [
           _buildText1("Order", order),
           Gap(5),
           _buildText1("Taxes", taxes),
           Gap(5),
           _buildText1("Delivery fees", fees),
           Gap(10),
           Divider(indent: 15, endIndent: 15),
           Gap(10),
           _buildText2("Total:", total, 16),
           Gap(20),
           _buildText2("Estimated delivery time:", "15 - 30 mins", 12),
         ],
       ),
     );
   }
   Widget _buildText1(String text1, String text2) {
     return Row(
       children: [
         Text(
           text1,
           style: AppTextStyle.grey16Regular,
         ),
         Spacer(),
         Text(
           text2,
           style: AppTextStyle.grey16Regular,
         ),
       ],
     );
   }

   Widget _buildText2(String text1, String text2, double size) {
     return Row(
       children: [
         Text(
           text1,
           style: TextStyle(fontWeight: FontWeight.w700, fontSize: size),
         ),
         Spacer(),
         Text(
           text2,
           style: TextStyle(fontWeight: FontWeight.w700, fontSize: size),
         ),
       ],
     );
   }
 }
