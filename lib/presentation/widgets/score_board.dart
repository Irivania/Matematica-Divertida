/// Widget para exibir placar de acertos e erros.
import 'package:flutter/material.dart';

class ScoreBoard extends StatelessWidget {
  final int correct;
  final int wrong;
  const ScoreBoard({required this.correct, required this.wrong, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.check, color: Colors.green),
        Text(' $correct', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(width: 24),
        Icon(Icons.close, color: Colors.red),
        Text(' $wrong', style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }
}
