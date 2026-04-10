/// Serviço responsável por gerar perguntas matemáticas dinâmicas conforme fase e modo.
/// Centraliza toda a lógica de geração, sem duplicidade.

import 'dart:math';
import '../../core/enums/math_operation.dart';
import '../../core/constants/game_constants.dart';
import '../../core/helpers/math_helpers.dart';
import '../../domain/entities/question.dart';
import '../../domain/entities/level.dart';
import '../../domain/entities/game_mode.dart';
import 'datasources/question_datasource.dart';

class QuestionGeneratorService implements QuestionDataSource {
  @override
  Level generateLevel(int phase, GameMode mode) {
    // Gera 10 perguntas únicas, simples, inteiras, sem repetições excessivas
    final questions = <Question>[];
    final seen = <String>{};
    int tentativas = 0;
    while (questions.length < GameConstants.questionsPerPhase && tentativas < 100) {
      final q = _generateEasyMathQuestion(phase);
      // Evita perguntas repetidas
      if (!seen.contains(q.statement)) {
        questions.add(q);
        seen.add(q.statement);
      }
      tentativas++;
    }
    return Level(number: phase, questions: questions);
  }

  /// Gera perguntas de matemática básica, inteiras, simples e rápidas
  Question _generateEasyMathQuestion(int phase) {
    // Aumenta levemente a faixa conforme a fase
    final min = 1 + (phase - 1);
    final max = 10 + (phase - 1) * 2;
    final ops = [MathOperation.addition, MathOperation.subtraction, MathOperation.multiplication, MathOperation.division];
    final op = ops[MathHelpers.randomInRange(0, ops.length - 1)];
    int a, b;
    switch (op) {
      case MathOperation.addition:
        a = MathHelpers.randomInRange(min, max);
        b = MathHelpers.randomInRange(min, max);
        return Question(
          statement: '$a + $b = ?',
          answer: a + b,
          operation: op,
          options: _generateOptions(a + b),
        );
      case MathOperation.subtraction:
        a = MathHelpers.randomInRange(min, max);
        b = MathHelpers.randomInRange(min, a); // Garante resultado >= 0
        return Question(
          statement: '$a - $b = ?',
          answer: a - b,
          operation: op,
          options: _generateOptions(a - b),
        );
      case MathOperation.multiplication:
        a = MathHelpers.randomInRange(min, max > 10 ? 10 : max); // Mantém multiplicação simples
        b = MathHelpers.randomInRange(min, max > 10 ? 10 : max);
        return Question(
          statement: '$a × $b = ?',
          answer: a * b,
          operation: op,
          options: _generateOptions(a * b),
        );
      case MathOperation.division:
        b = MathHelpers.randomInRange(min, max > 10 ? 10 : max);
        b = b == 0 ? 1 : b;
        a = b * MathHelpers.randomInRange(min, max > 10 ? 10 : max); // Garante divisão exata
        return Question(
          statement: '$a ÷ $b = ?',
          answer: a ~/ b,
          operation: op,
          options: _generateOptions(a ~/ b),
        );
      default:
        // Nunca deve cair aqui
        return Question(statement: 'Erro', answer: 0, operation: op, options: [0]);
    }
  }

  List<num> _generateOptions(num correct) {
    // Gera 3 opções erradas próximas do valor correto
    final options = <num>{correct};
    while (options.length < 4) {
      final delta = MathHelpers.randomInRange(1, 10);
      final sign = MathHelpers.randomInRange(0, 1) == 0 ? -1 : 1;
      final opt = correct + (delta * sign);
      options.add(opt);
    }
    return options.toList()..shuffle();
  }
}
