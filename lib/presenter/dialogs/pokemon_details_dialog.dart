import 'package:flutter/material.dart';
import 'package:pokemon_challenge/core/theme/app_colors.dart';
import 'package:pokemon_challenge/core/theme/app_text_styles.dart';
import 'package:pokemon_challenge/domain/entity/pokemon_data_entity.dart';
import 'package:pokemon_challenge/presenter/widgets/pokemon_details_progress_bar.dart';
import 'package:pokemon_challenge/utils/number_utils.dart';

class PokemonDetailsDialog extends StatelessWidget {
  final PokemonDataEntity pokemon;
  const PokemonDetailsDialog({super.key, required this.pokemon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 190,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pokemon.name,
                        style: AppTextStyles.xLarge.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '#${pokemon.number}',
                        style: AppTextStyles.medium.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  top: 70,
                  left: 0,
                  right: 0,
                  child: SizedBox(
                    height: 250,
                    child: Image.network(pokemon.img, fit: BoxFit.contain),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 120),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Estatíscas base',
                    style: AppTextStyles.medium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 24),

                  PokemonDetailsProgressBar(
                    title: 'Altura',
                    value: parseDoubleFromString(pokemon.height),
                    min: 0,
                    max: 10,
                  ),

                  const SizedBox(height: 16),

                  PokemonDetailsProgressBar(
                    title: 'Peso',
                    value: parseDoubleFromString(pokemon.weight),
                    min: 0,
                    max: 500,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
