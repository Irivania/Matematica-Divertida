/// Enum para o status/fase do jogo matemático
enum GamePhase {
  idle,        // Antes de iniciar
  playing,     // Jogando normalmente
  completed,   // Fase concluída (aguarda ação do usuário)
  fail,        // Errou ou tempo esgotado
  gameOver,    // Fim do jogo
  timeout,     // Tempo esgotado
}
