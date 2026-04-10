/// GameEngine centralizado: único ponto de verdade para regras do jogo matemático.
/// Controla fases, perguntas, validação, timer e progressão.

import '../entities/game_state.dart';
import '../entities/game_mode.dart';
import '../entities/level.dart';
import '../entities/question.dart';
import '../entities/game_status.dart';
import '../../data/question_generator_service.dart';
import '../../data/answer_validator_service.dart';
import '../../data/level_progression_service.dart';
import '../../data/timer_service.dart';
import '../../data/game_repository_impl.dart';
import '../repositories/game_repository.dart';

class GameEngine {
  late GameState _state;
  late Level _currentLevel;
  final QuestionGeneratorService _questionGen;
  final AnswerValidatorService _validator;
  final LevelProgressionService _progression;
  final TimerService _timer;
  final GameRepository _repository;

  GameEngine({
    QuestionGeneratorService? questionGen,
    AnswerValidatorService? validator,
    LevelProgressionService? progression,
    TimerService? timer,
    GameRepository? repository,
  })  : _questionGen = questionGen ?? QuestionGeneratorService(),
        _validator = validator ?? AnswerValidatorService(),
        _progression = progression ?? LevelProgressionService(),
        _timer = timer ?? TimerService(),
        _repository = repository ?? GameRepositoryImpl();

  GameState get state => _state;
  List<Question> get questions => _currentLevel.questions;
  Question get currentQuestion => _currentLevel.questions[_state.question - 1];

  /// Inicia o jogo no modo selecionado
  void startGame(GameMode mode) {
    _state = GameState(
      phase: 1,
      question: 1,
      correct: 0,
      wrong: 0,
      timeLeft: _timer.timeLeft,
      mode: mode,
      status: GameStatus.playing,
    );
    _currentLevel = _questionGen.generateLevel(1, mode);
    _timer.start();
  }

  /// Submete resposta do usuário para a questão atual
  void submitAnswer(num answer) {
    final isCorrect = _validator.validate(currentQuestion, answer);
    if (isCorrect) {
      _state = _state.copyWith(correct: _state.correct + 1);
    } else {
      _state = _state.copyWith(wrong: _state.wrong + 1);
    }
    nextQuestion();
  }

  /// Avança para a próxima questão ou fase
  void nextQuestion() {
    if (_state.question < questions.length) {
      _state = _state.copyWith(question: _state.question + 1);
    } else {
      advancePhase();
    }
  }

  /// Avança para a próxima fase
  void advancePhase() {
    if (_state.phase < 20) {
      _state = _state.copyWith(phase: _state.phase + 1, question: 1);
      _currentLevel = _questionGen.generateLevel(_state.phase, _state.mode);
      _timer.reset();
      _timer.start();
    } else {
      _state = _state.copyWith(status: GameStatus.success);
      _timer.stop();
    }
  }

  /// Marca fase como falha (tempo esgotado ou erro crítico)
  void failPhase() {
    _state = _state.copyWith(status: GameStatus.fail);
    _timer.stop();
  }

  /// Reseta a fase atual
  void resetPhase() {
    _state = _state.copyWith(question: 1, correct: 0, wrong: 0, status: GameStatus.playing);
    _currentLevel = _questionGen.generateLevel(_state.phase, _state.mode);
    _timer.reset();
    _timer.start();
  }

  /// Atualiza o timer (decrementa tempo restante)
  void tickTimer(Duration delta) {
    final newTime = _state.timeLeft - delta;
    if (newTime <= Duration.zero) {
      failPhase();
    } else {
      _state = _state.copyWith(timeLeft: newTime);
    }
  }
}
