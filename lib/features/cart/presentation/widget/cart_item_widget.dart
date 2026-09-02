import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hungry_app/core/constant/app_colors.dart';
import 'package:hungry_app/core/theme/app_text_style.dart';
import 'package:hungry_app/core/widgets/custom_elevated_button.dart';
import 'package:hungry_app/features/cart/domain/entities/cart_item_entity.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemEntity item;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final VoidCallback removeItem;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onAdd,
    required this.onRemove,
    required this.removeItem,
  });

  @override
  Widget build(BuildContext context) {
    final product = item.product;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;

        // Responsive values
        final imageWidth = width < 360 ? 90.0 : 120.0;
        final imageHeight = width < 360 ? 70.0 : 90.0;

        final horizontalGap = width < 360 ? 10.0 : 20.0;

        return Card(
          child: Padding(
            padding: EdgeInsets.all(
              width < 360 ? 10 : 16,
            ),

            child: Row(
              children: [
                /// Product Information

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        product.image,
                        width: imageWidth,
                        height: imageHeight,
                        fit: BoxFit.contain,
                      ),

                      Text(
                        product.name,
                        style: AppTextStyle.black16W700,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),

                      Text(
                        product.description,
                        style: AppTextStyle.black14Regular,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      Text(
                        '\$ ${item.unitPrice.toStringAsFixed(2)}',
                        style: AppTextStyle.black16W700,
                      ),
                    ],
                  ),
                ),

                // Quantity + Remove

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          _addIcon(onAdd),

                          Gap(horizontalGap),

                          Text(
                            item.quantity.toString(),
                            style: AppTextStyle.black16W700,
                          ),

                          Gap(horizontalGap),

                          _removeIcon(onRemove),
                        ],
                      ),

                      Gap(width < 360 ? 15 : 25),

                      CustomElevatedButton(
                        text: "Remove",
                        onPressed: removeItem,
                        height: 40,
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        fontSize: 18,
                        borderRadius: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _addIcon(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.all(4),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _removeIcon(VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(6),
        ),
        padding: const EdgeInsets.all(4),
        child: const Icon(
          Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }
}