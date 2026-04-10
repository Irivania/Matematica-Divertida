/// Widget para exibir o timer restante da fase.
import 'package:flutter/material.dart';

class TimerWidget extends StatelessWidget {
  final Duration timeLeft;
  const TimerWidget({required this.timeLeft, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.timer),
        const SizedBox(width: 8),
        Text('${timeLeft.inSeconds}s', style: Theme.of(context).textTheme.titleLarge),
      ],
    );
  }
}
