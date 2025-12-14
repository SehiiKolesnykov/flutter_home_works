import 'package:flutter/material.dart';

class AuthToggleButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;
  final bool isLeft;

  const AuthToggleButton({
    super.key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
    required this.isLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isSelected ? Colors.white : Colors.white24,
          foregroundColor: isSelected ? Colors.deepPurple : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.horizontal(
              left: isLeft ? const Radius.circular(12) : Radius.zero,
              right: isLeft ? Radius.zero : const Radius.circular(12),
            ),
          ),
        ),
        child: Text(text, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
      ),
    );
  }
}