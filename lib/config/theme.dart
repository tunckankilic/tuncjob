import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
    useMaterial3: true,
    primaryColor: const Color.fromARGB(255, 2, 16, 144),
    // primaryColorDark: Color(0xFFFC0028),
    // primaryColorLight: Color(0xFFFE9AAA),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'Optima',
    textTheme: const TextTheme(
      //headline1
      displayLarge: TextStyle(
        color: Color(0xFF2B2E4A),
        fontWeight: FontWeight.bold,
        fontSize: 36,
      ),
      //headline2
      displayMedium: TextStyle(
        color: Color(0xFF2B2E4A),
        fontWeight: FontWeight.bold,
        fontSize: 24,
      ),
      //headline3
      displaySmall: TextStyle(
        color: Color(0xFF2B2E4A),
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
      //headline4
      headlineMedium: TextStyle(
        color: Color(0xFF2B2E4A),
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
      //headline5
      headlineSmall: TextStyle(
        color: Color(0xFF2B2E4A),
        fontWeight: FontWeight.bold,
        fontSize: 14,
      ),
      //headline6
      titleLarge: TextStyle(
        color: Color(0xFF2B2E4A),
        fontWeight: FontWeight.normal,
        fontSize: 14,
      ),
      //bodyText1
      bodyLarge: TextStyle(
        color: Color(0xFF2B2E4A),
        fontWeight: FontWeight.normal,
        fontSize: 12,
      ),
      //bodyText2
      bodyMedium: TextStyle(
        color: Color(0xFF2B2E4A),
        fontWeight: FontWeight.normal,
        fontSize: 10,
      ),
    ),
    colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Colors.red[900]!,
        onPrimary: Colors.blue[900]!,
        secondary: Colors.red[600]!,
        onSecondary: Colors.blue[600]!,
        error: Colors.black,
        onError: Colors.red[200]!,
        background: const Color(0xFFF4F4F4),
        onBackground: Colors.white54,
        surface: Colors.red,
        onSurface: Colors.black),
  );
}
