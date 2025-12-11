import 'package:flutter/material.dart';

class TaskModel {
  final String title;
  final String subtitle;
  final IconData icon;
  final List<Color> gradientColors;
  final Widget screen;

  const TaskModel({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.gradientColors,
    required this.screen,
  });
}