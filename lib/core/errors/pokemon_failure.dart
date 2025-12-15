class PokemonFailure {
  final String message;

  PokemonFailure(this.message);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PokemonFailure && other.message == message;
  }

  @override
  int get hashCode {
    return message.hashCode;
  }

  @override
  String toString() => message;
}
