import 'package:flash_dictionary/colors.dart';
import 'package:flutter/material.dart';

final ThemeData themeData = _buildThemeData();

ThemeData _buildThemeData() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: pastelGreen,
      onPrimary: pastelGreen,
      secondary: pastelGreen,
      background: whitishColor,
      surface: whitishColor,
    ),
  );
}