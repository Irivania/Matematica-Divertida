/// Interface para repositório de persistência do jogo.
import '../entities/level.dart';
import '../entities/player_progress.dart';

abstract class GameRepository {
  Future<Level> fetchLevel(int number);
  Future<void> saveProgress(PlayerProgress progress);
  Future<PlayerProgress> loadProgress();
}
