import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/providers.dart';
import 'screens/auth_screen.dart';
import 'screens/habits_screen.dart';
import 'screens/add_habit_screen.dart';
import 'screens/habit_details_screen.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateProvider);

    return MaterialApp(
      title: 'Трекер Звичок',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
          primary: Colors.deepPurple,
          secondary: Colors.indigo,
          surface: Colors.deepPurple.shade900,
          background: Colors.deepPurple.shade900,
          surfaceVariant: Colors.indigo.shade900.withValues(alpha: 0.6),
        ),
        scaffoldBackgroundColor: Colors.deepPurple.shade900,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        cardTheme: CardThemeData(
          color: Colors.indigo.withValues(alpha: 0.2),
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            elevation: 8,
          ),
        ),
        textTheme: const TextTheme(
          headlineLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(color: Colors.white),
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      home: user.when(
        data: (u) => u != null ? const HabitsScreen() : const AuthScreen(),
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.white)),
        error: (_, __) => const Center(child: Text('Помилка', style: TextStyle(color: Colors.white))),
      ),
      routes: {
        '/habits': (_) => const HabitsScreen(),
        '/add_habit': (_) => const AddHabitScreen(),
        '/habit_details': (_) => const HabitDetailsScreen(),
      },
    );
  }
}