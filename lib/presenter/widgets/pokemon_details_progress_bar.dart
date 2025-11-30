import 'package:flutter/material.dart';
import 'package:pokemon_challenge/core/theme/app_colors.dart';
import 'package:pokemon_challenge/core/theme/app_text_styles.dart';

class PokemonDetailsProgressBar extends StatelessWidget {
  final String title;
  final double value;
  final double min;
  final double max;

  const PokemonDetailsProgressBar({
    super.key,
    required this.title,
    required this.value,
    required this.min,
    required this.max,
  });

  @override
  Widget build(BuildContext context) {
    double adjustedValue = value.clamp(min, max);
    double percentage = (adjustedValue - min) / (max - min);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title: $value', style: AppTextStyles.small),
        SizedBox(height: 5),
        Container(
          width: double.infinity,
          height: 8,
          decoration: BoxDecoration(
            color: AppColors.gray,
            borderRadius: BorderRadius.circular(20),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: percentage,
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.teal,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
