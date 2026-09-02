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
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final width = constraints.maxWidth;

                  // Responsive Values
                  final horizontalPadding = width < 360
                      ? 12.0
                      : width < 600
                      ? 16.0
                      : 24.0;

                  final gapAfterSearch = width < 360
                      ? 20.0
                      : 30.0;

                  final gapAfterCategories = width < 360
                      ? 20.0
                      : 30.0;


                  final crossAxisCount = width < 600 ? 2 : 3;

                  final crossAxisSpacing = width < 360
                      ? 8.0
                      : 10.0;

                  final mainAxisSpacing = width < 360
                      ? 8.0
                      : 10.0;

                  final childAspectRatio = width < 360
                      ? 0.65
                      : 0.8;

                  return Padding(
                    padding: EdgeInsets.all(
                      horizontalPadding,
                    ),

                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,

                      children: [
                        /// Header

                        const CustomHeaderWidget(),

                        const Gap(15),

                        /// Search

                        SearchField(
                          search: _search,

                          onChanged: (value) {
                            context
                                .read<HomeCubit>()
                                .searchProducts(value);
                          },
                        ),

                        Gap(gapAfterSearch),

                        /// Categories


                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,

                          child: Row(
                            children: List.generate(
                              categories.length,

                                  (index) {
                                return CategoriesList(
                                  index: index,

                                  categories: categories,

                                  selectedIndex:
                                  selectedIndex,

                                  onTap: () {
                                    setState(() {
                                      selectedIndex =
                                          index;
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

                        Gap(gapAfterCategories),

                        /// Products

                        Expanded(
                          child: BlocBuilder<
                              HomeCubit,
                              HomeState>(
                            builder: (context, state) {
                              // Loading
                              if (state is HomeLoading) {
                                return const Center(
                                  child:
                                  CircularProgressIndicator(),
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
                                final products =
                                    state.products;

                                // No Products
                                if (products.isEmpty) {
                                  return const Center(
                                    child: Text(
                                      'No products found',
                                    ),
                                  );
                                }

                                return GridView.builder(
                                  itemCount:
                                  products.length,

                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount:
                                    crossAxisCount,

                                    crossAxisSpacing:
                                    crossAxisSpacing,

                                    mainAxisSpacing:
                                    mainAxisSpacing,

                                    childAspectRatio:
                                    childAspectRatio,
                                  ),

                                  itemBuilder:
                                      (context, index) {
                                    final product =
                                    products[index];

                                    return GestureDetector(
                                      onTap: () {
                                        context.push(
                                          AppRoutes
                                              .productDetails,
                                          extra: product,
                                        );
                                      },

                                      child:
                                      CustomProductWidget(
                                        product:
                                        product,
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
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}