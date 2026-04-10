/// Tela principal do jogo: exibe perguntas, timer, placar e input de resposta.
import 'package:flutter/material.dart';
import '../../domain/engine/game_engine.dart';
import '../../domain/entities/game_mode.dart';
import '../../domain/entities/game_status.dart';
import '../widgets/answer_input_field.dart';
import '../widgets/timer_widget.dart';
import '../widgets/score_board.dart';

class GameScreen extends StatefulWidget {
  final GameEngine engine;
  const GameScreen({required this.engine, super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late GameEngine _engine;
  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _engine = widget.engine;
  }

  void _submit() {
    final value = num.tryParse(_controller.text);
    if (value != null) {
      setState(() {
        _engine.submitAnswer(value);
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = _engine.state;
    final question = _engine.currentQuestion;
    return Scaffold(
      appBar: AppBar(title: Text('Fase ${state.phase}')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TimerWidget(timeLeft: state.timeLeft),
            const SizedBox(height: 16),
            ScoreBoard(correct: state.correct, wrong: state.wrong),
            const SizedBox(height: 32),
            Text(
              'Pergunta ${state.question}/10',
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              question.statement,
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            AnswerInputField(
              controller: _controller,
              onSubmitted: (_) => _submit(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _submit,
              child: const Text('Responder'),
            ),
          ],
        ),
      ),
    );
  }
}
