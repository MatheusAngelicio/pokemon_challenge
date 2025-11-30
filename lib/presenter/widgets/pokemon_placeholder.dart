import 'package:flutter/widgets.dart';

class PokemonPlaceholder extends StatefulWidget {
  final double size;

  const PokemonPlaceholder({super.key, this.size = 60});

  @override
  State<PokemonPlaceholder> createState() => _PokemonPlaceholderState();
}

class _PokemonPlaceholderState extends State<PokemonPlaceholder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Image.asset(
        'assets/pokemon_logo.png',
        width: widget.size,
        height: widget.size,
      ),
    );
  }
}
