import 'game_mode.dart';
import 'game_status.dart';

/// Estado imutável do jogo
class GameState {
  final int phase;
  final int question;
  final int correct;
  final int wrong;
  final Duration timeLeft;
  final GameMode mode;
  final GamePhase phaseStatus;

  const GameState({
    required this.phase,
    required this.question,
    required this.correct,
    required this.wrong,
    required this.timeLeft,
    required this.mode,
    required this.phaseStatus,
  });

  /// Cria uma cópia modificada (imutabilidade)
  GameState copyWith({
    int? phase,
    int? question,
    int? correct,
    int? wrong,
    Duration? timeLeft,
    GameMode? mode,
    GamePhase? phaseStatus,
  }) {
    return GameState(
      phase: phase ?? this.phase,
      question: question ?? this.question,
      correct: correct ?? this.correct,
      wrong: wrong ?? this.wrong,
      timeLeft: timeLeft ?? this.timeLeft,
      mode: mode ?? this.mode,
      phaseStatus: phaseStatus ?? this.phaseStatus,
    );
  }
}
