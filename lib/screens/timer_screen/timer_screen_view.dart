import 'package:flutter/foundation.dart';
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
        padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
        child: Column(
          children: [
            AppBar(
              title: TextField(
                controller: presenter.timerNameTextController,
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
                onTap: () {
                  presenter.timerNameTextController.selection =
                      TextSelection.fromPosition(
                    TextPosition(
                      offset: presenter.timerNameTextController.text.length,
                    ),
                  );
                },
              ),
              // centerTitle: true,
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
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 10.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 5),
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: StreamBuilder<int>(
                          stream: presenter.timerModel.rawTime,
                          initialData: 0,
                          builder: (context, snapshot) {
                            final displayTime = StopWatchTimer.getDisplayTime(
                                snapshot.data ?? 0);
                            return Column(
                              children: [
                                Text(
                                  displayTime,
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
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TimerInfoRowWidget(
              text: 'Started',
              valueListenable: presenter.startedTimerTextState,
            ),
            const SizedBox(
              height: 10,
            ),
            TimerInfoRowWidget(
              text: 'Finished',
              valueListenable: presenter.finishedTimerTextState,
            ),
            const SizedBox(
              height: 15,
            ),
            ValueListenableBuilder(
                valueListenable: presenter.resultTimerTextState,
                builder: (context, result, _) {
                  return Text(
                    result,
                    style: Theme.of(context).textTheme.titleMedium,
                  );
                }),
            TextField(),
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
    required this.valueListenable,
  });

  final String text;
  final ValueListenable<String> valueListenable;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: valueListenable,
          builder: (context, time, _) {
            return Text(
              time,
              style: Theme.of(context).textTheme.titleSmall,
            );
          },
        ),
      ],
    );
  }
}
