import 'package:flutter/material.dart';
import 'package:hungry_app/core/widgets/custom_text_form_field.dart';

class SearchField extends StatelessWidget {
  final TextEditingController search;
  final ValueChanged<String> onChanged;

  const SearchField({
    super.key,
    required this.search,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: CustomTextFormField(
        prefixIcon: const Icon(Icons.search),
        controller: search,
        hint: "Search",
        hintColor: Colors.black,
        onChanged: onChanged,
      ),
    );
  }
}