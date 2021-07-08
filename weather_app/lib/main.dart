import 'package:flutter/material.dart';
import 'pages/loading.dart';
import 'pages/home.dart';

void main() {
  runApp(
    MaterialApp(
      routes: {
        '/': (context) => Loading(),
        '/home': (context) => Home(),
      }
    ),
  );
}