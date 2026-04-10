/// Serviço responsável por controlar a progressão de fases e pontuação.
/// Centraliza toda a lógica de avanço, sem duplicidade.
import '../../domain/entities/player_progress.dart';
import '../../core/constants/game_constants.dart';

class LevelProgressionService {
  PlayerProgress advance(PlayerProgress current, bool success) {
    final nextPhase = success
        ? (current.phase < GameConstants.totalPhases ? current.phase + 1 : current.phase)
        : current.phase;
    return PlayerProgress(
      phase: nextPhase,
      correct: success ? current.correct + 1 : current.correct,
      wrong: success ? current.wrong : current.wrong + 1,
    );
  }
}
