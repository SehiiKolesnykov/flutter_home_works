import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

/// Кастомна кнопка для всього додатку.
/// Адаптивна завдяки sizer (розміри в % від екрану).
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        // Розмір адаптивний (80% ширини екрану, 6% висоти)
        minimumSize: Size(80.w, 6.h),
        // Закруглені кути
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(text),
    );
  }
}