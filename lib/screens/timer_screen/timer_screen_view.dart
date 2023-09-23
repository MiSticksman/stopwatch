import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:timer/screens/timer_screen/timer_screen_presenter.dart';
import 'package:timer/screens/timer_screen/timer_state.dart';

class TimerScreenView extends StatelessWidget {
  const TimerScreenView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final presenter = context.read<TimerScreenPresenter>();
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 70, left: 30, right: 30),
        child: Column(
          children: [
            AppBar(
              title: Text(
                'Timer name',
                style: textTheme.titleSmall?.copyWith(fontSize: 40),
              ),
              centerTitle: true,
            ),
            ValueListenableBuilder(
                valueListenable: presenter.timerStatusState,
                builder: (context, timerStatus, _) {
                  return GestureDetector(
                    onTap: () {
                      if (timerStatus == TimerState.initial) {
                        return presenter.start();
                      } else if (timerStatus == TimerState.processing) {
                        return presenter.pause();
                      } else if (timerStatus == TimerState.pause) {
                        return presenter.resume();
                      }
                    },
                    onLongPress: () {
                      if (timerStatus != TimerState.finished) {
                        return presenter.finish();
                      }
                    },
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.yellow,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 5.0, right: 5.0, top: 10),
                        child: FittedBox(
                          child: StreamBuilder<int>(
                            stream: presenter.timerModel.rawTime,
                            initialData: 0,
                            builder: (context, snapshot) {
                              final value = snapshot.data;
                              final displayTime =
                                  StopWatchTimer.getDisplayTime(value ?? 0);
                              return Column(
                                children: [
                                  Text(
                                    displayTime,
                                    style: textTheme.titleLarge,
                                  ),
                                  Text(
                                    value.toString(),
                                    style: textTheme.titleLarge,
                                  ),
                                  ValueListenableBuilder<String>(
                                    valueListenable:
                                        presenter.timerDispalyedStatus,
                                    builder: (context, status, _) {
                                      return Text(
                                        status,
                                        style: textTheme.titleMedium,
                                      );
                                    },
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  );
                }),
            const SizedBox(
              height: 20,
            ),
            const TimerInfoRowWidget(
              text: 'Started 00:00:00',
            ),
            const SizedBox(
              height: 20,
            ),
            const TimerInfoRowWidget(
              text: 'Finished 00:00:00',
            ),
            const SizedBox(
              height: 20,
            ),
            TextField()
          ],
        ),
      ),
    );
  }
}

class TimerInfoRowWidget extends StatelessWidget {
  const TimerInfoRowWidget({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
