/// Ponto de entrada do app Matemática Divertida.
/// Controla navegação e ciclo de vida do GameEngine.
import 'package:flutter/material.dart';
import 'domain/engine/game_engine.dart';
import 'domain/entities/game_mode.dart';
import 'domain/entities/game_status.dart';
import 'presentation/screens/home_screen.dart';
import 'presentation/screens/game_screen.dart';
import 'presentation/screens/result_screen.dart';

void main() {
  runApp(const MathGameApp());
}

class MathGameApp extends StatefulWidget {
  const MathGameApp({super.key});

  @override
  State<MathGameApp> createState() => _MathGameAppState();
}

class _MathGameAppState extends State<MathGameApp> {
  late GameEngine _engine;
  GameMode? _selectedMode;

  @override
  void initState() {
    super.initState();
    _engine = GameEngine();
  }

  void _startGame(GameMode mode) {
    setState(() {
      _selectedMode = mode;
      _engine.startGame(mode);
    });
  }

  void _restart() {
    setState(() {
      _selectedMode = null;
      _engine = GameEngine();
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget screen;
    if (_selectedMode == null) {
      screen = HomeScreen(onModeSelected: _startGame);
    } else if (_engine.state.status == GameStatus.success || _engine.state.status == GameStatus.fail) {
      screen = ResultScreen(
        correct: _engine.state.correct,
        wrong: _engine.state.wrong,
        onRestart: _restart,
      );
    } else {
      screen = GameScreen(engine: _engine);
    }
    return MaterialApp(
      title: 'Matemática Divertida',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: screen,
    );
  }
}
