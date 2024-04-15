import 'package:flutter/material.dart';

class AppTheme {
  final ColorScheme _colorScheme;

  AppTheme({required ColorScheme colorScheme}) : _colorScheme = colorScheme;

  ThemeData get theme {
    return ThemeData(
      fontFamily: 'OpenSans',
      colorScheme: _colorScheme,
    );
  }
}
