/// Entidade que representa uma pergunta matemática gerada dinamicamente.
/// Não contém lógica de UI ou dependências externas.
import '../../core/enums/math_operation.dart';

class Question {
  final String statement;
  final num answer;
  final MathOperation operation;
  final List<num> options;

  Question({
    required this.statement,
    required this.answer,
    required this.operation,
    required this.options,
  });
}
