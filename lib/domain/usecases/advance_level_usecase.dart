/// Caso de uso para avançar de fase e atualizar progresso.
import '../entities/player_progress.dart';

abstract class AdvanceLevelUseCase {
  PlayerProgress advance(PlayerProgress current, bool success);
}
