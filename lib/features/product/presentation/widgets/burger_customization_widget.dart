import 'package:flutter/material.dart';
import 'package:flutter_gap/flutter_gap.dart';
import 'package:hungry_app/core/constant/app_colors.dart';
import 'package:hungry_app/core/theme/app_text_style.dart';

class BurgerCustomizationWidget extends StatelessWidget {
  const BurgerCustomizationWidget({
    super.key,
    required this.spicyLevel,
    required this.onSpicyLevelChanged,
  });

  /// Current spice level, expected to be in the [0, 1] range.
  final double spicyLevel;

  /// Called when the user drags the slider to a new value.
  final ValueChanged<double>? onSpicyLevelChanged;

  static const double _minSpicy = 0;
  static const double _maxSpicy = 1;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Image.asset('assets/images/details.png', height: 230),
        const Gap(10),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CustomizationDescription(textTheme: textTheme),
                const Gap(10),
                Text(
                  'Spicy',
                  style: AppTextStyle.black16W700,
                ),

                Slider(
                  min: _minSpicy,
                  max: _maxSpicy,
                  value: spicyLevel.clamp(_minSpicy, _maxSpicy),
                  onChanged: onSpicyLevelChanged,
                  activeColor: AppColors.primary,
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('🥶', style: TextStyle(fontSize: 20)),
                    Text('🌶️', style: TextStyle(fontSize: 20)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

/// The descriptive rich-text shown above the slider.
class _CustomizationDescription extends StatelessWidget {
  const _CustomizationDescription({required this.textTheme});

  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    final baseStyle = TextStyle(
      fontSize: 14,
      color: const Color(0xff3D3030),
      height: 1.7,
    );
    final boldStyle = baseStyle.copyWith(fontWeight: FontWeight.bold);

    return Text.rich(
      TextSpan(
        style: baseStyle,
        children: [
          TextSpan(text: 'Customize', style: boldStyle),
          const TextSpan(text: ' Your Burger to Your Tastes. '),
          TextSpan(text: 'Ultimate', style: boldStyle),
          const TextSpan(text: ' Experience'),
        ],
      ),
    );
  }
}
