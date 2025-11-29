import 'package:flutter/material.dart';
import 'package:pokemon_challenge/core/theme/app_colors.dart';
import 'package:pokemon_challenge/core/theme/app_text_styles.dart';

class PokemonListHeader extends StatelessWidget {
  const PokemonListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 190,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Pokédex",
            style: AppTextStyles.xLarge.copyWith(color: AppColors.white),
          ),
          const SizedBox(height: 12),
          Image.asset(
            'assets/pokemon_logo.png',
            height: 34,
            width: 34,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
