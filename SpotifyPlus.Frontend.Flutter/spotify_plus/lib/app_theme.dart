import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData.dark().copyWith(
  progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.green
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(primary: Colors.green)
  ),
);
