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
    final questions = <Question>[];
    for (int i = 0; i < GameConstants.questionsPerPhase; i++) {
      questions.add(_generateQuestion(phase, mode));
    }
    return Level(number: phase, questions: questions);
  }

  Question _generateQuestion(int phase, GameMode mode) {
    // Define operações possíveis por modo
    final operations = mode == GameMode.child
        ? [
            MathOperation.addition,
            MathOperation.subtraction,
            MathOperation.multiplication,
            MathOperation.division,
          ]
        : [
            MathOperation.addition,
            MathOperation.subtraction,
            MathOperation.multiplication,
            MathOperation.division,
            if (phase > 5) MathOperation.percentage,
            if (phase > 10) MathOperation.squareRoot,
            if (phase > 15) MathOperation.power,
          ];
    final op = operations[MathHelpers.randomInRange(0, operations.length - 1)];
    // Define faixa de números conforme fase
    final min = mode == GameMode.child
        ? GameConstants.minNumberChild + (phase - 1)
        : GameConstants.minNumberAdult + (phase * 2);
    final max = mode == GameMode.child
        ? GameConstants.maxNumberChild + (phase * 2)
        : GameConstants.maxNumberAdult + (phase * 10);
    // Gera números
    final a = MathHelpers.randomInRange(min, max);
    final b = MathHelpers.randomInRange(min, max);
    // Monta pergunta e resposta
    switch (op) {
      case MathOperation.addition:
        return Question(
          statement: '$a + $b = ?',
          answer: a + b,
          operation: op,
          options: _generateOptions(a + b),
        );
      case MathOperation.subtraction:
        return Question(
          statement: '$a - $b = ?',
          answer: a - b,
          operation: op,
          options: _generateOptions(a - b),
        );
      case MathOperation.multiplication:
        return Question(
          statement: '$a × $b = ?',
          answer: a * b,
          operation: op,
          options: _generateOptions(a * b),
        );
      case MathOperation.division:
        final divisor = b == 0 ? 1 : b;
        return Question(
          statement: '${a * divisor} ÷ $divisor = ?',
          answer: a,
          operation: op,
          options: _generateOptions(a),
        );
      case MathOperation.percentage:
        return Question(
          statement: 'Qual é ${(a % 100) + 1}% de $b?',
          answer: ((a % 100) + 1) * b / 100,
          operation: op,
          options: _generateOptions(((a % 100) + 1) * b / 100),
        );
      case MathOperation.squareRoot:
        final n = a * a;
        return Question(
          statement: '√$n = ?',
          answer: a,
          operation: op,
          options: _generateOptions(a),
        );
      case MathOperation.power:
        final exp = (b % 3) + 2;
        return Question(
          statement: '$a ^ $exp = ?',
          answer: num.parse((pow(a.toDouble(), exp)).toStringAsFixed(2)),
          operation: op,
          options: _generateOptions(num.parse((pow(a.toDouble(), exp)).toStringAsFixed(2))),
        );
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
