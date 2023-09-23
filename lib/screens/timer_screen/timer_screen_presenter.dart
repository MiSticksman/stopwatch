import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:timer/screens/timer_screen/timer_state.dart';

class TimerScreenPresenter {
  TimerScreenPresenter({required this.timerModel});

  TimerModel timerModel;

  late final String started;
  late final String finished;

  final TextEditingController timerNameTextController =
      TextEditingController(text: 'TimerName');
  final TextEditingController descriptionTextController =
      TextEditingController();

  final ValueNotifier<TimerState> timerStatusState =
      ValueNotifier(TimerState.initial);
  final ValueNotifier<String> timerDispalyedStatus = ValueNotifier('start');

  void init() {
    timerStatusState.addListener(_getActualTimerButtonText);
  }

  void start() {
    if (timerStatusState.value == TimerState.initial) {
      timerModel.startTimer();
      started = DateTime.now().toLocal().toString();
      timerStatusState.value = TimerState.processing;
    }
  }

  void pause() {
    if (timerStatusState.value == TimerState.processing) {
      timerModel.pauseTimer();
      timerStatusState.value = TimerState.pause;
    }
  }

  void resume() {
    if (timerStatusState.value == TimerState.pause) {
      timerModel.startTimer();
      timerStatusState.value = TimerState.processing;
    }
  }

  void finish() {
    if (timerStatusState.value == TimerState.processing ||
        timerStatusState.value == TimerState.pause) {
      timerModel.finishTimer();
      finished = DateTime.now().toLocal().toString();
      timerStatusState.value = TimerState.finished;
      //todo add data to database
      dispose();
    }
  }

  void _getActualTimerButtonText() {
    switch (timerStatusState.value) {
      case TimerState.initial:
        timerDispalyedStatus.value = 'start';
        return;
      case TimerState.processing:
        timerDispalyedStatus.value = 'stop';
        break;
      case TimerState.pause:
        timerDispalyedStatus.value = 'resume';
        break;
      case TimerState.finished:
        timerDispalyedStatus.value = 'start';
        break;
    }
  }

  void dispose() {
    //todo implement
  }
}

class TimerModel {
  final _stopWatchTimer = StopWatchTimer(mode: StopWatchMode.countUp);

  Stream<int> get rawTime => _stopWatchTimer.rawTime;

  void startTimer() {
    _stopWatchTimer.onStartTimer();
  }

  void pauseTimer() {
    _stopWatchTimer.onStopTimer();
  }

  void finishTimer() {
    _stopWatchTimer.onResetTimer();
  }
}
