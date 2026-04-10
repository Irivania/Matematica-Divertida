// Testes unitários para o GameEngine e serviços centrais.
// Garante que a lógica de jogo está correta, sem dependência de UI.
import 'package:flutter_test/flutter_test.dart';
import 'package:matematica_divertida/domain/engine/game_engine.dart';
import 'package:matematica_divertida/domain/entities/game_mode.dart';
import 'package:matematica_divertida/domain/entities/game_status.dart';

void main() {
  group('GameEngine', () {
    late GameEngine engine;

    setUp(() {
      engine = GameEngine();
    });

    test('Inicia no modo criança corretamente', () {
      engine.startGame(GameMode.child);
      expect(engine.state.phase, 1);
      expect(engine.state.status, GameStatus.playing);
      expect(engine.questions.length, 10);
    });

    test('Avança questão e fase corretamente', () {
      engine.startGame(GameMode.child);
      for (int i = 0; i < 10; i++) {
        engine.submitAnswer(engine.currentQuestion.answer);
      }
      expect(engine.state.phase, 2);
      expect(engine.state.question, 1);
    });

    test('Registra acertos e erros', () {
      engine.startGame(GameMode.child);
      final wrong = engine.currentQuestion.answer + 1000;
      engine.submitAnswer(wrong);
      expect(engine.state.wrong, 1);
      engine.submitAnswer(engine.currentQuestion.answer);
      expect(engine.state.correct, 1);
    });

    test('Finaliza ao completar 20 fases', () {
      engine.startGame(GameMode.child);
      for (int f = 0; f < 20; f++) {
        for (int i = 0; i < 10; i++) {
          engine.submitAnswer(engine.currentQuestion.answer);
        }
      }
      expect(engine.state.status, GameStatus.success);
    });
  });
}
