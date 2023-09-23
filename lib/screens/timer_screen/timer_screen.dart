
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/screens/timer_screen/timer_screen_presenter.dart';
import 'package:timer/screens/timer_screen/timer_screen_view.dart';

class TimerScreen extends StatelessWidget {
  const TimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider<TimerScreenPresenter>(
      create: (context) => TimerScreenPresenter(
        timerModel: context.read<TimerModel>(),
      ),
      child: const TimerScreenView(),
    );
  }
}