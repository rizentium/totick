import 'package:flutter/material.dart';

class ToTickTheme {
  static ThemeData primary = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),
    useMaterial3: true,
  );
}
