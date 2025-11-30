import 'package:flutter/material.dart';
import 'package:pokemon_challenge/core/theme/app_colors.dart';
import 'package:pokemon_challenge/core/theme/app_text_styles.dart';

class PokemonAlertDialog extends StatelessWidget {
  final String title;
  final String subtitle;
  final String buttonText;
  final VoidCallback onPressed;

  const PokemonAlertDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: Text(title, style: AppTextStyles.title),
      content: Text(
        subtitle,
        style: AppTextStyles.medium.copyWith(color: AppColors.darkGray),
      ),
      actions: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: onPressed,
            child: Text(
              buttonText,
              style: AppTextStyles.medium.copyWith(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
