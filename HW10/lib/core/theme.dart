import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  primarySwatch: Colors.deepPurple,
  scaffoldBackgroundColor: Colors.transparent,
  textTheme: const TextTheme(
    headlineMedium: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white),
    titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
  ),
);