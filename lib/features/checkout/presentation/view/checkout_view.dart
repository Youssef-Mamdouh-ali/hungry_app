import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry_app/core/constant/app_colors.dart';
import 'package:hungry_app/core/theme/app_text_style.dart';
import 'package:hungry_app/core/widgets/custom_elevated_button.dart';

import '../widget/order_details_widget.dart';
import '../widget/success_dialog.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({super.key});

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  String selectedPayment = 'Cash';
  bool saveCard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Order summary",
                style: AppTextStyle.black20W700,
              ),
              Gap(15),
              OrderDetailsWidget(
                order: "\$16.48",
                fees: "\$1.5",
                total: "\$18.19",
                taxes: "\$0.3",
              ),
              Gap(30),
              Text(
                "Payment methods",
                style: AppTextStyle.black20W700,
              ),
              Gap(20),

              /// Cash
              ListTile(
                onTap: () {
                  setState(() {
                    selectedPayment = 'Cash';
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
                tileColor: Color(0xff3C2F2F),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),

                leading: Image.asset('assets/icons/dollarr.png', width: 50),

                title: Text(
                  "Cash on Delivery",
                  style: AppTextStyle.white20Bold
                ),

                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: 'Cash',
                  groupValue: selectedPayment,
                  onChanged: (value) =>
                      setState(() => selectedPayment = value!),
                ),
              ),
              Gap(20),

              /// Debit
              ListTile(
                onTap: () {
                  setState(() {
                    selectedPayment = 'visa';
                  });
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(12),
                ),
                tileColor: Colors.grey,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 2,
                  horizontal: 16,
                ),

                leading: Image.asset('assets/icons/visa.png', width: 50),

                title: Text(
                  "Debit card",
                  style: AppTextStyle.white20Bold,
                ),
                subtitle: Text(
                  "3566 **** **** 0505",
                  style: AppTextStyle.white14Regular,
                ),
                trailing: Radio<String>(
                  activeColor: Colors.white,
                  value: 'visa',
                  groupValue: selectedPayment,
                  onChanged: (value) =>
                      setState(() => selectedPayment = value!),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Checkbox(value: saveCard, onChanged: (v) {
                    setState(() {
                      saveCard = v!;
                    });
                  }),
                  Gap(5),
                  Text(
                    "Save card details for future payments",
                    style: AppTextStyle.black14Regular,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.only(top: 8.0, bottom: 45),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 12),
          width: double.infinity,
          height: 90,
          decoration: BoxDecoration(
              borderRadius: BorderRadiusGeometry.circular(12),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 3,
                    blurRadius: 4
                )
              ]
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total",
                      style: AppTextStyle.black18W700,
                    ),
                    Text(
                      "\$ 20",
                      style:  AppTextStyle.black24W700,
                    ),
                  ],
                ),
              ),
              CustomElevatedButton(
                text: "Pay Now",
                onPressed: () {
                  showDialog(context: context, builder: (context) {
                    return Dialog(child: SuccessDialog());
                  });
                },
                height: 50,
                width: 160,
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
