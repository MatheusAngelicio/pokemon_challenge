import 'package:flutter/material.dart';
import 'package:pokemon_challenge/core/theme/app_colors.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({super.key, required TextEditingController controller})
    : _controller = controller;

  final TextEditingController _controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.lightkGray,
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Nome ou código do Pokemon',
          border: InputBorder.none,
          prefixIcon: const Icon(Icons.search, color: AppColors.darkGray),
        ),
        onChanged: (value) {},
      ),
    );
  }
}
