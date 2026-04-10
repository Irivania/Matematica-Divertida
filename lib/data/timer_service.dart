/// Serviço responsável por controlar o timer do jogo (por fase).
/// Não depende de UI, totalmente testável.
import 'dart:async';
import '../../core/constants/game_constants.dart';

class TimerService {
  Duration _timeLeft = GameConstants.phaseTime;
  Timer? _timer;
  void Function(Duration)? onTick;
  void Function()? onTimeout;

  Duration get timeLeft => _timeLeft;
  bool get isRunning => _timer != null && _timer!.isActive;

  void start({Duration? duration}) {
    _timeLeft = duration ?? GameConstants.phaseTime;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _timeLeft -= const Duration(seconds: 1);
      onTick?.call(_timeLeft);
      if (_timeLeft <= Duration.zero) {
        timer.cancel();
        onTimeout?.call();
      }
    });
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  void reset() {
    stop();
    _timeLeft = GameConstants.phaseTime;
  }
}
