/// Entidade que representa o progresso do jogador ao longo do jogo.
class PlayerProgress {
  final int phase;
  final int correct;
  final int wrong;

  PlayerProgress({
    required this.phase,
    required this.correct,
    required this.wrong,
  });
}
