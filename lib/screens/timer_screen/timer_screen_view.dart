import 'package:flutter/material.dart';

class TimerScreenView extends StatelessWidget {
  const TimerScreenView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
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
            GestureDetector(
              onTap: null,
              child: Container(
                height: 300,
                width: 300,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.yellow,
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 5.0, right: 5.0, top: 10),
                  child: FittedBox(
                    child: Column(
                      children: [
                        Text(
                          '00:00:00',
                          style: textTheme.titleLarge,
                        ),
                        Text('start', style: textTheme.titleMedium),
                      ],
                    ),
                  ),
                ),
              ),
            ),
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
            TextField(

            )
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

