/// Implementação mock do repositório do jogo, pronta para integração futura com Firebase/local.
import '../../domain/entities/level.dart';
import '../../domain/entities/player_progress.dart';
import '../../domain/repositories/game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  PlayerProgress? _progress;

  @override
  Future<Level> fetchLevel(int number) async {
    // Mock: retorna vazio, integração futura
    throw UnimplementedError();
  }

  @override
  Future<void> saveProgress(PlayerProgress progress) async {
    _progress = progress;
  }

  @override
  Future<PlayerProgress> loadProgress() async {
    return _progress ?? PlayerProgress(phase: 1, correct: 0, wrong: 0);
  }
}
