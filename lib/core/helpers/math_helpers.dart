/// Funções auxiliares matemáticas para o jogo.
class MathHelpers {
  /// Gera um número aleatório entre [min] e [max] (inclusive).
  static int randomInRange(int min, int max) {
    return min + (DateTime.now().microsecondsSinceEpoch % (max - min + 1));
  }

  /// Calcula porcentagem de [value] sobre [total].
  static double percentage(num value, num total) {
    if (total == 0) return 0;
    return (value / total) * 100;
  }
}
