/// Extensões utilitárias para números.
extension NumExtensions on num {
  /// Retorna verdadeiro se o número for inteiro.
  bool get isInt => this % 1 == 0;
}
