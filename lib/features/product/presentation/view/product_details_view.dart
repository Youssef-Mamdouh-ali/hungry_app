import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry_app/core/constant/app_colors.dart';
import 'package:hungry_app/core/di/injection_container.dart';
import 'package:hungry_app/core/theme/app_text_style.dart';
import 'package:hungry_app/core/widgets/custom_elevated_button.dart';
import 'package:hungry_app/features/cart/domain/entities/cart_item_entity.dart';
import 'package:hungry_app/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:hungry_app/features/home/domain/entities/product_entity.dart';
import 'package:hungry_app/features/product/presentation/cubit/product_details_cubit.dart';
import 'package:hungry_app/features/product/presentation/cubit/product_details_state.dart';

import '../widgets/burger_customization_widget.dart';
import '../widgets/side_options_widget.dart';
import '../widgets/topping_widget.dart';

class ProductDetailsView extends StatefulWidget {
  final ProductEntity product;

  const ProductDetailsView({
    super.key,
    required this.product,
  });

  @override
  State<ProductDetailsView> createState() =>
      _ProductDetailsViewState();
}

class _ProductDetailsViewState
    extends State<ProductDetailsView> {

  double sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    final product = widget.product;

    return BlocProvider(
      create: (_) => sl<ProductCubit>()
        ..getProductOptions(product.price),

      child: Scaffold(

        appBar: AppBar(
          elevation: 0,
          backgroundColor: AppColors.white,

          leading: IconButton(
            onPressed: context.pop,
            icon: const Icon(Icons.arrow_back),
          ),

          title: Text(
            product.name,
            style: AppTextStyle.black20Bold,
          ),
        ),


        body: SafeArea(
          child: BlocBuilder<ProductCubit, ProductState>(
            builder: (context, state) {

              // Loading
              if (state is ProductLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              // Failure
              if (state is ProductFailure) {
                return Center(
                  child: Text(state.message),
                );
              }

              // Success
              if (state is ProductSuccess) {
                return SingleChildScrollView(
                  padding: const EdgeInsets.only(
                    bottom: 120,
                  ),

                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Center(
                        child: SizedBox(
                          height: 220,
                          child: Image.asset(
                            product.image,
                            fit: BoxFit.contain,
                          )
                        ),
                      ),

                      const Gap(10),

                      Padding(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Text(
                          product.name,
                          style:
                          AppTextStyle.black20W700,
                        ),
                      ),

                      const Gap(5),


                      Padding(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Text(
                          product.description,
                          style:
                          AppTextStyle.black14Regular,
                        ),
                      ),

                      const Gap(5),


                      Padding(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                        child: Text(
                          "⭐ ${product.rating}",
                          style:
                          AppTextStyle.black14Regular,
                        ),
                      ),

                      const Gap(20),

                      BurgerCustomizationWidget(
                        spicyLevel: sliderValue,

                        onSpicyLevelChanged: (value) {
                          setState(() {
                            sliderValue = value;
                          });
                        },
                      ),

                      const Gap(20),

                      ToppingWidget(
                        toppings: state.toppings,
                        selectedToppings:
                        state.selectedToppings,
                      ),

                      const Gap(20),

                      SideOptionsWidget(
                        sideOptions: state.sideOptions,
                        selectedSideOptions:
                        state.selectedSideOptions,
                      ),
                    ],
                  ),
                );
              }

              return const SizedBox();
            },
          ),
        ),

        bottomSheet: BlocBuilder<ProductCubit, ProductState>(
          builder: (context, state) {
            double totalPrice = product.price;

            if (state is ProductSuccess) {
              totalPrice = state.totalPrice;
            }

            return Padding(
              padding: const EdgeInsets.only(
                top: 8,
                bottom: 45,
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                ),
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
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total",
                            style: AppTextStyle.black18W700,
                          ),
                          Text(
                            "\$ ${totalPrice.toStringAsFixed(2)}",
                            style: AppTextStyle.black20W700,
                          ),
                        ],
                      ),
                    ),

                    CustomElevatedButton(
                      text: "Add to Cart",
                      onPressed: state is ProductSuccess
                          ? () {
                        final cartItem = CartItemEntity(
                          product: product,
                          toppings: state.selectedToppings,
                          sideOptions: state.selectedSideOptions,
                          spicyLevel: sliderValue,
                          quantity: 1,
                        );

                        context
                            .read<CartCubit>()
                            .addToCart(cartItem);

                        context.pop();
                      }
                          : null,
                      height: 50,
                      width: 160,
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}