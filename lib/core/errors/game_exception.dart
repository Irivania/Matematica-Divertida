/// Exceção base para erros do jogo matemático.
class GameException implements Exception {
  final String message;
  GameException(this.message);

  @override
  String toString() => 'GameException: $message';
}
