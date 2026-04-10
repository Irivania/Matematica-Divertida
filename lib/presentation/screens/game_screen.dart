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
  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _engine = widget.engine;
    _engine.onTick = () {
      if (mounted) setState(() {});
    };
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  void _submit() {
    final value = num.tryParse(_controller.text);
    if (value != null) {
      setState(() {
        _engine.submitAnswer(value);
        _controller.clear();
      });
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = _engine.state;
    final question = _engine.currentQuestion;
    return Scaffold(
      appBar: AppBar(title: Text('Fase ${state.phase}')),
      body: Stack(
        children: [
          Padding(
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
                  focusNode: _focusNode,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _submit,
                  child: const Text('Responder'),
                ),
              ],
            ),
          ),
          if (state.phaseStatus == GamePhase.completed)
            Positioned.fill(
              child: Container(
                color: Colors.black54,
                child: Center(
                  child: Card(
                    elevation: 8,
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Parabéns! Fase ${state.phase} concluída',
                              style: Theme.of(context).textTheme.headlineSmall),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              setState(() {
                                _engine.goToNextPhase();
                              });
                            },
                            child: const Text('Próxima fase'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
