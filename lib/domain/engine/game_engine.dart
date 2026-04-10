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
  void Function()? onTick;

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
  /// Inicia o jogo matemático
  void startGame(GameMode mode) {
    _state = GameState(
      phase: 1,
      question: 1,
      correct: 0,
      wrong: 0,
      timeLeft: _timer.timeLeft,
      mode: mode,
      phaseStatus: GamePhase.playing,
    );
    _currentLevel = _questionGen.generateLevel(1, mode);
    _timer.onTick = (duration) {
      _state = _state.copyWith(timeLeft: duration);
      if (onTick != null) onTick!();
    };
    _timer.start();
  }

  /// Submete resposta do usuário para a questão atual
  /// Se errar, encerra a partida e reinicia; se acertar todas, avança automaticamente
  void submitAnswer(num answer) {
    if (_state.phaseStatus != GamePhase.playing) return;
    final isCorrect = _validator.validate(currentQuestion, answer);
    if (isCorrect) {
      _state = _state.copyWith(correct: _state.correct + 1);
      if (_state.correct == questions.length) {
        // Acertou todas, avança automaticamente para próxima fase
        goToNextPhase();
      } else {
        nextQuestion();
      }
    } else {
      // Errou, encerra partida e reinicia
      endAndRestartGame(GamePhase.fail);
    }
  }

  /// Marca fase como concluída (aguarda ação do usuário)
  void completePhase() {
    _state = _state.copyWith(phaseStatus: GamePhase.completed);
    _timer.stop();
  }

  /// Avança para a próxima fase (chamado explicitamente pela UI)
  void goToNextPhase() {
    if (_state.phase < GameConstants.totalPhases) {
      _state = _state.copyWith(
        phase: _state.phase + 1,
        question: 1,
        correct: 0,
        wrong: 0,
        phaseStatus: GamePhase.playing,
        timeLeft: GameConstants.phaseTime,
      );
      _currentLevel = _questionGen.generateLevel(_state.phase, _state.mode);
      _timer.reset();
      _timer.start();
    } else {
      _state = _state.copyWith(phaseStatus: GamePhase.gameOver);
      _timer.stop();
    }
  }

  /// Avança para a próxima questão
  void nextQuestion() {
    if (_state.question < questions.length) {
      _state = _state.copyWith(question: _state.question + 1);
    }
    // Não avança de fase aqui, só se acertar todas
  }

  // advancePhase removido: agora só goToNextPhase()

  /// Marca fase como falha (tempo esgotado) e reinicia
  void failPhase() {
    endAndRestartGame(GamePhase.timeout);
  }

  /// Encerra a partida e reinicia o jogo do zero
  void endAndRestartGame(GamePhase reason) {
    _state = _state.copyWith(phaseStatus: reason);
    _timer.stop();
    // Reinicia o jogo após breve delay para feedback visual
    Future.delayed(const Duration(seconds: 1), () {
      startGame(_state.mode);
      if (onTick != null) onTick!();
    });
  }

  /// Reseta a fase atual (após erro ou timeout)
  void resetPhase() {
    _state = _state.copyWith(
      question: 1,
      correct: 0,
      wrong: 0,
      phaseStatus: GamePhase.playing,
      timeLeft: GameConstants.phaseTime,
    );
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
