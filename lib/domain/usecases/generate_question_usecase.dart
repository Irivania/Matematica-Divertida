/// Caso de uso para geração de perguntas matemáticas dinâmicas.
import '../entities/level.dart';
import '../entities/question.dart';
import '../entities/game_mode.dart';

abstract class GenerateQuestionUseCase {
  Level generateLevel(int phase, GameMode mode);
}
