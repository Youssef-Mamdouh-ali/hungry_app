import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hungry_app/core/constant/app_colors.dart';
import 'package:hungry_app/core/theme/app_text_style.dart';
import 'package:hungry_app/features/product/domain/entities/side_option_entity.dart';
import 'package:hungry_app/features/product/presentation/cubit/product_details_cubit.dart';

class SideOptionsWidget extends StatelessWidget {
  final List<SideOptionEntity> sideOptions;
  final List<SideOptionEntity> selectedSideOptions;

  const SideOptionsWidget({
    super.key,
    required this.sideOptions,
    required this.selectedSideOptions,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Side Options",
            style: AppTextStyle.black18W700,
          ),

          const Gap(20),

          SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: sideOptions.length,

              itemBuilder: (context, index) {
                final sideOption = sideOptions[index];

                final isSelected =
                selectedSideOptions.contains(sideOption);

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
                          sideOption.image,
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
                                sideOption.name,
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
                                    .toggleSideOption(
                                  sideOption,
                                );
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