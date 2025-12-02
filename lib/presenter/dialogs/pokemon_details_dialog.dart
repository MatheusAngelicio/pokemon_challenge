import 'package:flutter/material.dart';
import 'package:pokemon_challenge/analytics/analytics_channel.dart';
import 'package:pokemon_challenge/analytics/battery_channel.dart';
import 'package:pokemon_challenge/core/theme/app_colors.dart';
import 'package:pokemon_challenge/core/theme/app_text_styles.dart';
import 'package:pokemon_challenge/domain/entity/pokemon_data_entity.dart';
import 'package:pokemon_challenge/presenter/widgets/pokemon_bordered_text.dart';
import 'package:pokemon_challenge/presenter/widgets/pokemon_card_item.dart';
import 'package:pokemon_challenge/presenter/widgets/pokemon_details_progress_bar.dart';
import 'package:pokemon_challenge/utils/number_utils.dart';

class PokemonDetailsDialog extends StatelessWidget {
  final PokemonDataEntity pokemon;
  final List<PokemonDataEntity> relatedPokemons;

  const PokemonDetailsDialog({
    super.key,
    required this.pokemon,
    required this.relatedPokemons,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          color: AppColors.white,
          child: SingleChildScrollView(
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
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(24),
                          bottomRight: Radius.circular(24),
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => Navigator.of(context).pop(),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.add,
                                  size: 10,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                          Column(
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
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 8,
                          runSpacing: 4,
                          children: pokemon.type
                              .map((type) => PokemonBorderedText(text: type))
                              .toList(),
                        ),
                      ),

                      const SizedBox(height: 32),

                      Text('Estatísticas base', style: AppTextStyles.medium),
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
                      const SizedBox(height: 32),
                      Text('Relacionados', style: AppTextStyles.medium),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: relatedPokemons.length,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          separatorBuilder: (_, _) => const SizedBox(width: 12),
                          itemBuilder: (context, index) {
                            final related = relatedPokemons[index];
                            return SizedBox(
                              width: 150,
                              child: PokemonCardItem(
                                imageUrl: related.img,
                                name: related.name,
                                number: related.number,
                                onCardTap: () async {
                                  int batteryLevel =
                                      await BatteryChannel.getBatteryLevel();
                                  await AnalyticsChannel.logEvent(
                                    'battery_check',
                                    {'level': batteryLevel.toString()},
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
