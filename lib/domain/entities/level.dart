/// Entidade que representa uma fase do jogo.
import 'question.dart';

class Level {
  final int number;
  final List<Question> questions;

  Level({
    required this.number,
    required this.questions,
  });
}
