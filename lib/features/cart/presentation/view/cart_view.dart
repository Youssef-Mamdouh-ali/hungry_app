import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry_app/core/constant/app_colors.dart';
import 'package:hungry_app/core/router/app_routes.dart';
import 'package:hungry_app/core/theme/app_text_style.dart';
import 'package:hungry_app/core/widgets/custom_elevated_button.dart';
import 'package:hungry_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:hungry_app/features/cart/presentation/cubit/cart_state.dart';
import 'package:hungry_app/features/cart/widget/cart_item_widget.dart'
    show CartItemWidget;

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cart', style: AppTextStyle.black20Bold)),

      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is! CartUpdated) {
            return const SizedBox();
          }

          final items = state.items;

          // =========================
          // EMPTY CART
          // =========================

          if (items.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }

          // =========================
          // CART
          // =========================

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: items.length,

                    itemBuilder: (context, index) {
                      final item = items[index];

                      return CartItemWidget(
                        item: item,

                        onAdd: () {
                          context.read<CartCubit>().increaseQuantity(index);
                        },

                        onRemove: () {
                          context.read<CartCubit>().decreaseQuantity(index);
                        },

                        removeItem: () {
                          context.read<CartCubit>().removeFromCart(index);
                        },
                      );
                    },

                    separatorBuilder: (_, __) {
                      return const SizedBox(height: 12);
                    },
                  ),
                ),

                // =========================
                // TOTAL
                // =========================
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  width: double.infinity,
                  height: 90,

                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 3,
                        blurRadius: 4,
                      ),
                    ],
                  ),

                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Total', style: AppTextStyle.black18W700),

                            Text(
                              '\$ ${state.totalPrice.toStringAsFixed(2)}',
                              style: AppTextStyle.black24W700,
                            ),
                          ],
                        ),
                      ),

                      CustomElevatedButton(
                        text: 'Pay Now',

                        onPressed: () {
                          context.push(AppRoutes.checkout);
                        },

                        height: 50,
                        width: 160,

                        backgroundColor: AppColors.primary,

                        foregroundColor: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
