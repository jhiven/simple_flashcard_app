import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getTheme({required ColorScheme colorScheme}) {
    return ThemeData(
      fontFamily: 'OpenSans',
      colorScheme: colorScheme,
    );
  }
}
