import 'dart:async';

import 'package:flutter/foundation.dart';

enum TimerState { stopped, running, paused, finished }

class FocusTimerController {
  Timer? _timer;
  final int totalDurationSeconds;

  final ValueNotifier<int> remainingSeconds;
  final ValueNotifier<TimerState> state = ValueNotifier(TimerState.stopped);

  FocusTimerController({required int initialMinutes})
    : totalDurationSeconds = initialMinutes * 60,
      remainingSeconds = ValueNotifier(initialMinutes * 60);

  double get progress => 1 - (remainingSeconds.value / totalDurationSeconds);

  String get formattedTime {
    final minutes = (remainingSeconds.value ~/ 60).toString().padLeft(2, '0');
    final seconds = (remainingSeconds.value % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void start() {
    if (state.value == TimerState.running) return;
    state.value = TimerState.running;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds.value > 0) {
        remainingSeconds.value--;
      } else {
        finish();
      }
    });
  }

  void pause() {
    if (state.value == TimerState.running) {
      _timer?.cancel();
      state.value = TimerState.paused;
    }
  }

  void resume() {
    if (state.value == TimerState.paused) {
      start();
    }
  }

  void stop() {
    _timer?.cancel();
    remainingSeconds.value = totalDurationSeconds;
    state.value = TimerState.stopped;
  }

  void finish() {
    _timer?.cancel();
    state.value = TimerState.finished;
    // TODO: Adicionar trigger de haptics/som suave local
  }

  void dispose() {
    _timer?.cancel();
    remainingSeconds.dispose();
    state.dispose();
  }
}
