import 'package:flutter/material.dart';
import 'package:pokemon_challenge/core/theme/app_colors.dart';
import 'package:pokemon_challenge/core/theme/app_text_styles.dart';
import 'package:pokemon_challenge/presenter/widgets/pokemon_placeholder.dart';

class PokemonCardItem extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String number;
  final VoidCallback onCardTap;

  const PokemonCardItem({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.number,
    required this.onCardTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCardTap,
      child: Card(
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(color: AppColors.borderGray, width: 1.5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                    frameBuilder:
                        (context, child, frame, wasSynchronouslyLoaded) {
                          if (wasSynchronouslyLoaded) {
                            return child;
                          }
                          if (frame == null) {
                            return Container(
                              width: double.infinity,
                              height: 150,
                              alignment: Alignment.center,
                              color: AppColors.white,
                              child: const PokemonPlaceholder(),
                            );
                          }
                          return child;
                        },
                  ),
                ),
              ),
              Text(
                name,
                style: AppTextStyles.large,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                '#$number',
                style: AppTextStyles.medium.copyWith(color: AppColors.darkGray),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: CircleAvatar(
                  radius: 10,
                  backgroundColor: AppColors.black,
                  child: const Icon(
                    Icons.add,
                    size: 14,
                    color: AppColors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
