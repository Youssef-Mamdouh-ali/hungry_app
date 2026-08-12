import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hungry_app/core/constant/app_colors.dart';
import 'package:hungry_app/core/router/app_routes.dart';
import 'package:hungry_app/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:hungry_app/features/auth/presentation/cubit/auth_state.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _logoSlideAnimation;
  late Animation<Offset> _imageSlideAnimation;

  @override
  void initState() {
    super.initState();
    context.read<AuthCubit>().checkAuthStatus();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _logoSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _imageSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,

      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.go(AppRoutes.layout);
          }

          if (state is AuthUnauthenticated) {
            context.go(AppRoutes.login);
          }

          if (state is AuthFailure) {
            context.go(AppRoutes.login);
          }
        },

        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),

            child: FadeTransition(
              opacity: _fadeAnimation,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,

                children: [
                  const Gap(200),

                  SlideTransition(
                    position: _logoSlideAnimation,

                    child: SvgPicture.asset("assets/logo.svg", width: 250),
                  ),

                  const Spacer(),

                  SlideTransition(
                    position: _imageSlideAnimation,

                    child: Image.asset("assets/images/image 1.png"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
