/// Funções auxiliares matemáticas para o jogo.
import 'dart:math';
class MathHelpers {
  /// Gera um número aleatório entre [min] e [max] (inclusive).
  static final _random = Random();
  static int randomInRange(int min, int max) {
    if (min > max) {
      final temp = min;
      min = max;
      max = temp;
    }
    return min + _random.nextInt(max - min + 1);
  }

  /// Calcula porcentagem de [value] sobre [total].
  static double percentage(num value, num total) {
    if (total == 0) return 0;
    return (value / total) * 100;
  }
}
