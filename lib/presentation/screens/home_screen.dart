/// Tela inicial do jogo: seleção de modo (criança/adulto).
import 'package:flutter/material.dart';
import '../../domain/entities/game_mode.dart';

class HomeScreen extends StatelessWidget {
  final void Function(GameMode) onModeSelected;
  const HomeScreen({required this.onModeSelected, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Matemática Divertida')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => onModeSelected(GameMode.child),
              child: const Text('Modo Criança'),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => onModeSelected(GameMode.adult),
              child: const Text('Modo Adulto'),
            ),
          ],
        ),
      ),
    );
  }
}
