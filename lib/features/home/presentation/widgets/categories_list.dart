import 'package:flutter/material.dart';
import 'package:hungry_app/core/constant/app_colors.dart';
class CategoriesList extends StatelessWidget {
  final int index;
  final List<String> categories;
  final int selectedIndex;
  final VoidCallback onTap;

  const CategoriesList({
    super.key,
    required this.index,
    required this.categories,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(left: 12),
        width: index == 0 ? 60 : 80,
        height: 40,
        decoration: BoxDecoration(
          color: selectedIndex == index
              ? AppColors.primary
              : Colors.grey.shade400,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            categories[index],
            style: TextStyle(
              color: selectedIndex == index
                  ? AppColors.white
                  : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}