/// Serviço responsável por validar respostas do usuário.
/// Centraliza toda a lógica de validação, sem duplicidade.
import '../../domain/entities/question.dart';

class AnswerValidatorService {
  bool validate(Question question, num userAnswer) {
    // Permite pequena margem para operações com ponto flutuante
    if ((question.answer - userAnswer).abs() < 0.01) return true;
    return false;
  }
}
