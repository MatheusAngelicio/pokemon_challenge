import 'package:flutter/material.dart';
import 'package:pokemon_challenge/core/theme/app_colors.dart';

class PokemonBorderedText extends StatelessWidget {
  final String text;
  final Color borderColor;
  final Color textColor;
  final EdgeInsetsGeometry padding;
  final double borderRadius;

  const PokemonBorderedText({
    super.key,
    required this.text,
    this.borderColor = AppColors.gray,
    this.textColor = AppColors.black,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.borderRadius = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(text, style: TextStyle(color: textColor)),
    );
  }
}
