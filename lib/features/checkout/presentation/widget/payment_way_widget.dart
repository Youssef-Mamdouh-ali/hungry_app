import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';

class PaymentWayWidget extends StatelessWidget {
  Widget leading;

  Widget title;

  Widget? subTitle;

  Widget trailing;

  Color? color ;

  PaymentWayWidget({
    super.key,
     required this.leading,
    required this.title,
    required this.trailing,
    this.subTitle,
    this.color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color:color ?? Color(0xff3C2F2F),
      ),
      child: Row(
        children: [
          leading ,
          Gap(20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              title,
              Gap(7),
              ?subTitle
            ],
          ),
          Spacer(),
          trailing
        ],
      )
    );
  }
}
