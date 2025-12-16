import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sizer/sizer.dart';

import 'styles/app_styles.dart';
import 'providers/theme_provider.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('app_settings');

  final prefs = await SharedPreferences.getInstance();
  final isDark = prefs.getBool('isDark') ?? true;

  runApp(MyApp(initialDark: isDark));
}

class MyApp extends StatelessWidget {
  final bool initialDark;

  const MyApp({super.key, required this.initialDark});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return ChangeNotifierProvider(
          create: (_) => ThemeProvider(initialDark ? ThemeMode.dark : ThemeMode.light),
          child: Consumer<ThemeProvider>(
            builder: (context, themeProvider, child) {
              final baseTheme = ThemeData(
                useMaterial3: true,
                textTheme: AppStyles.textTheme,
              );

              return MaterialApp(
                title: 'Мультимедійний Додаток',
                debugShowCheckedModeBanner: false,
                themeMode: themeProvider.themeMode,
                theme: baseTheme.copyWith(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: AppStyles.netflixRed,
                    brightness: Brightness.light,
                  ),
                ),
                darkTheme: baseTheme.copyWith(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: AppStyles.netflixRed,
                    brightness: Brightness.dark,
                  ),
                  textTheme: AppStyles.textTheme.apply(
                    bodyColor: Colors.white,
                    displayColor: Colors.white,
                  ),
                ),
                home: const HomeScreen(),
              );
            },
          ),
        );
      },
    );
  }
}