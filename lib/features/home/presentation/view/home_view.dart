import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry_app/core/di/injection_container.dart';
import 'package:hungry_app/core/router/app_routes.dart';
import 'package:hungry_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:hungry_app/features/home/presentation/cubit/home_state.dart';

import '../widgets/categories_list.dart';
import '../widgets/custom_header_widget.dart';
import '../widgets/custom_product_widget.dart';
import '../widgets/search_field.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _search = TextEditingController();

  final List<String> categories = [
    'All',
    'Combos',
    'Sliders',
    'Classic',
  ];

  int selectedIndex = 0;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeCubit>()..getProducts(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // ================= HEADER =================

                    const CustomHeaderWidget(),

                    const Gap(15),

                    // ================= SEARCH =================
                    SearchField(
                      search: _search,
                      onChanged: (value) {
                        context.read<HomeCubit>().searchProducts(value);
                      },
                    ),

                    const Gap(30),

                    // ================= CATEGORIES =================

                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                          categories.length,
                              (index) {
                            return CategoriesList(
                              index: index,
                              categories: categories,
                              selectedIndex: selectedIndex,

                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });

                                context
                                    .read<HomeCubit>()
                                    .filterByCategory(
                                  categories[index],
                                );
                              },
                            );
                          },
                        ),
                      ),
                    ),

                    const Gap(30),

                    // ================= PRODUCTS =================

                    Expanded(
                      child: BlocBuilder<HomeCubit, HomeState>(
                        builder: (context, state) {

                          // Loading
                          if (state is HomeLoading) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          // Error
                          if (state is HomeFailure) {
                            return Center(
                              child: Text(
                                state.message,
                              ),
                            );
                          }

                          // Success
                          if (state is HomeSuccess) {
                            final products = state.products;

                            // No products
                            if (products.isEmpty) {
                              return const Center(
                                child: Text(
                                  'No products found',
                                ),
                              );
                            }

                            return GridView.builder(
                              itemCount: products.length,

                              gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 5,
                                childAspectRatio: 0.7,
                              ),

                              itemBuilder: (context, index) {
                                final product = products[index];

                                return GestureDetector(
                                    onTap: () {
                                      context.push(
                                        AppRoutes.productDetails,
                                        extra: product,
                                      );
                                    },

                                  child: CustomProductWidget(
                                    product: product,
                                  ),
                                );
                              },
                            );
                          }

                          return const SizedBox();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}