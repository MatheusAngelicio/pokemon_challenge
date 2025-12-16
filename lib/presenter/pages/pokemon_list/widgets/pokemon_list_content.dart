import 'package:flutter/material.dart';
import 'package:pokemon_challenge/core/theme/app_colors.dart';
import 'package:pokemon_challenge/core/theme/app_text_styles.dart';
import 'package:pokemon_challenge/presenter/cubits/pokemon_list/pokemon_list_state.dart';
import 'package:pokemon_challenge/presenter/pages/pokemon_list/widgets/pokemon_list_grid_section.dart';
import 'package:pokemon_challenge/presenter/pages/pokemon_list/widgets/pokemon_list_header_section.dart';

class PokemonListContent extends StatefulWidget {
  final PokemonListLoadedState data;
  const PokemonListContent({super.key, required this.data});

  @override
  State<PokemonListContent> createState() => _PokemonListContentState();
}

class _PokemonListContentState extends State<PokemonListContent> {
  late final ScrollController _scrollController;

  static const double _backToTopThreshold = 5000;
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      final shouldShow = _scrollController.offset > _backToTopThreshold;
      if (shouldShow != _showBackToTop) {
        setState(() => _showBackToTop = shouldShow);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomScrollView(
          controller: _scrollController,
          slivers: [
            PokemonListHeaderSection(),
            PokemonListGridSection(data: widget.data),
            const SliverToBoxAdapter(child: SizedBox(height: 80)),
          ],
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 20,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 250),
            opacity: _showBackToTop ? 1 : 0,
            child: IgnorePointer(
              ignoring: !_showBackToTop,
              child: Center(
                child: GestureDetector(
                  onTap: () {
                    _scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeOut,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: .55),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Voltar ao topo',
                      style: AppTextStyles.medium.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
