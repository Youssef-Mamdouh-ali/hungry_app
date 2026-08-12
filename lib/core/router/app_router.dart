import 'package:go_router/go_router.dart';
import 'package:hungry_app/core/router/app_routes.dart';
import 'package:hungry_app/features/auth/presentation/view/login_view.dart';
import 'package:hungry_app/features/auth/presentation/view/sign_up_view.dart';
import 'package:hungry_app/features/checkout/presentation/view/checkout_view.dart';
import 'package:hungry_app/features/home/domain/entities/product_entity.dart';
import 'package:hungry_app/layout.dart';
import 'package:hungry_app/splash_view.dart';

import '../../features/product/presentation/view/product_details_view.dart';

final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: AppRoutes.layout, builder: (_, _) => const Layout()),
    GoRoute(path: AppRoutes.splash, builder: (_, _) => const SplashView()),
    GoRoute(path: AppRoutes.login, builder: (_, _) => const LoginView()),
    GoRoute(path: AppRoutes.signUp, builder: (_, _) => const SignUpView()),
    GoRoute(
      path: AppRoutes.productDetails,
      builder: (context, state) {
        final product = state.extra as ProductEntity;

        return ProductDetailsView(product: product);
      },
    ),
    GoRoute(path: AppRoutes.checkout, builder: (_, _) => const CheckoutView()),
  ],
);
