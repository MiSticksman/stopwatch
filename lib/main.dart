import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer/screens/timer_screen/timer_screen.dart';
import 'package:timer/screens/timer_screen/timer_screen_presenter.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Change notifier',
      theme: ThemeData(
        fontFamily: 'Strong',
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontFamily: 'Strong',
            fontSize: 64,
            fontWeight: FontWeight.w400,
          ),
          titleMedium: TextStyle(
            fontFamily: 'Strong',
            fontSize: 40,
            fontWeight: FontWeight.w400,
          ),
          titleSmall: TextStyle(
            fontFamily: 'Strong',
            fontSize: 32,
            fontWeight: FontWeight.w400,
          ),
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const TimerScreen(),
    );
  }
}
