import 'package:flutter/material.dart';
import 'package:hw_7/screens/ProfileScreen.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'Мій профіль',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            useMaterial3: true,
          ),

          initialRoute: '/',

          routes: {
            '/': (context) => const ProfileScreen(),
          }
          ,
        );
      }
    );
  }
}