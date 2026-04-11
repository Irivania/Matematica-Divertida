/// Ponto de entrada do app Matemática Divertida.
/// Controla navegação e ciclo de vida do GameEngine.
import 'package:flutter/material.dart';
import 'domain/engine/game_engine.dart';
import 'domain/entities/game_mode.dart';
import 'domain/entities/game_status.dart';
import 'presentation/screens/mode_selection_page.dart';
import 'presentation/screens/game_screen.dart';
import 'presentation/screens/result_screen.dart';
import 'presentation/screens/child_profile.dart';
import 'presentation/screens/adult_profile.dart';

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
    return MaterialApp(
      title: 'Matemática Divertida',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ModeSelectionPage(
        onModeSelected: (modeType) {
          final gameMode = modeType == ModeType.child ? GameMode.child : GameMode.adult;
          _engine.startGame(gameMode);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => GameScreen(
                engine: _engine,
                onExit: _restart,
              ),
            ),
          );
        },
      ),
    );
  }
}
