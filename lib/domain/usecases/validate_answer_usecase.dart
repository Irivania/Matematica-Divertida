/// Caso de uso para validação de respostas do usuário.
import '../entities/question.dart';

abstract class ValidateAnswerUseCase {
  bool validate(Question question, num userAnswer);
}
