import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class TimerScreenPresenter {
  TimerScreenPresenter({required this.timerModel});

  TimerModel timerModel;
  late final String started;
  late final String finished;

  TextEditingController descriptionTextController = TextEditingController();

  void start() {
    timerModel.startTimer();
    started = DateTime.now().toLocal().toString();
  }

  void pause() {
    timerModel.pauseTimer();
  }

  void finish() {
    timerModel.startTimer();
    finished = DateTime.now().toLocal().toString();
  }

}

class TimerModel extends ChangeNotifier {
  final _stopWatchTimer = StopWatchTimer(mode: StopWatchMode.countUp);

  void startTimer() {
    _stopWatchTimer.onStartTimer();
    notifyListeners();
  }

  void pauseTimer() {
    _stopWatchTimer.onStartTimer();
    notifyListeners();
  }

  void finishTimer() {
    _stopWatchTimer.onResetTimer();
    notifyListeners();
  }
}
