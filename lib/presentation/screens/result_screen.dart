/// Tela de resultado final do jogo.
import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int correct;
  final int wrong;
  final VoidCallback onRestart;
  const ResultScreen({required this.correct, required this.wrong, required this.onRestart, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resultado Final')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Acertos: $correct', style: Theme.of(context).textTheme.headlineMedium),
            Text('Erros: $wrong', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: onRestart,
              child: const Text('Jogar Novamente'),
            ),
          ],
        ),
      ),
    );
  }
}
