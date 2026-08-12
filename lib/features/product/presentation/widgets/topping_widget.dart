import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hungry_app/core/constant/app_colors.dart';
import 'package:hungry_app/core/theme/app_text_style.dart';
import 'package:hungry_app/features/product/domain/entities/topping_entity.dart';
import 'package:hungry_app/features/product/presentation/cubit/product_details_cubit.dart';

class ToppingWidget extends StatelessWidget {
  final List<ToppingEntity> toppings;
  final List<ToppingEntity> selectedToppings;

  const ToppingWidget({
    super.key,
    required this.toppings,
    required this.selectedToppings,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Toppings",
            style: AppTextStyle.black18W700,
          ),

          const Gap(20),

          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: toppings.length,

              itemBuilder: (context, index) {
                final topping = toppings[index];

                final isSelected =
                selectedToppings.contains(topping);

                return Container(
                  width: 90,
                  height: 80,
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.15),
                        blurRadius: 10,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
                      ),
                    ],
                    color: const Color(0xff3C2F2F),
                    borderRadius: BorderRadius.circular(16),
                  ),

                  child: Column(
                    children: [
                      Container(
                        height: 60,
                        width: 90,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                          BorderRadius.circular(16),
                        ),
                        child: Image.asset(
                          topping.image,
                          fit: BoxFit.cover,
                        ),
                      ),

                      const Gap(5),

                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 3,
                        ),

                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                topping.name,
                                overflow: TextOverflow.ellipsis,
                                style:
                                AppTextStyle.white12W600,
                              ),
                            ),

                            const Gap(5),

                            GestureDetector(
                              onTap: () {
                                context
                                    .read<ProductCubit>()
                                    .toggleTopping(topping);
                              },

                              child: CircleAvatar(
                                radius: 10,
                                backgroundColor:
                                isSelected
                                    ? Colors.green
                                    : Colors.red,

                                child: Icon(
                                  isSelected
                                      ? Icons.check
                                      : Icons.add,
                                  color: AppColors.white,
                                  size: 17,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },

              separatorBuilder: (context, index) {
                return const SizedBox(width: 10);
              },
            ),
          ),
        ],
      ),
    );
  }
}