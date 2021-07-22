import 'package:flutter/material.dart';
import 'package:lube_timer/pages/timer_screen.dart';

void main() {

  runApp(
    MaterialApp(
      initialRoute: '/main',
      routes: {
        '/main': (context) => TimerScreen(),
      }
    )
  );
}