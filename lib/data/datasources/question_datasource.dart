/// DataSource responsável por fornecer perguntas e níveis (mock inicial, pronto para integração futura).
import '../../domain/entities/level.dart';
import '../../domain/entities/game_mode.dart';

abstract class QuestionDataSource {
  Level generateLevel(int phase, GameMode mode);
}
