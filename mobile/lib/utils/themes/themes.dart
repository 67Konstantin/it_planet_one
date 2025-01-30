import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,

  // Фон экрана
  scaffoldBackgroundColor: Colors.white,

  // Основной цвет
  primaryColor: Colors.black,

  // Набор цветов (ColorScheme)
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Colors.black,
    onPrimary: Colors.white,
    secondary: Colors.black,
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.white,
    background: Colors.white,
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
  ),

  // Текстовые стили со шрифтом iosevka и чёрным цветом.
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w900,
      fontSize: 32,
      color: Colors.black,
    ),
    displayMedium: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w700,
      fontSize: 28,
      color: Colors.black,
    ),
    displaySmall: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w400,
      fontSize: 24,
      color: Colors.black,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w700,
      fontSize: 22,
      color: Colors.black,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: Colors.black,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w400,
      fontSize: 18,
      color: Colors.black,
    ),
    titleLarge: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w600,
      fontSize: 18,
      color: Colors.black,
    ),
    titleMedium: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Colors.black,
    ),
    titleSmall: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w300,
      fontSize: 14,
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w300,
      fontSize: 12,
      color: Colors.black,
    ),
    labelLarge: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: Colors.black,
    ),
    labelMedium: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: Colors.black,
    ),
    labelSmall: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: Colors.black,
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,

  // Фон экрана
  scaffoldBackgroundColor: Colors.black,

  // Основной цвет
  primaryColor: Colors.white,

  // Набор цветов (ColorScheme)
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.white,
    onPrimary: Colors.black,
    secondary: Colors.white,
    onSecondary: Colors.black,
    error: Colors.red,
    onError: Colors.white,
    background: Colors.black,
    onBackground: Colors.white,
    surface: Colors.black,
    onSurface: Colors.white,
  ),

  // Текстовые стили со шрифтом iosevka и белым цветом.
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w900,
      fontSize: 32,
      color: Colors.white,
    ),
    displayMedium: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w700,
      fontSize: 28,
      color: Colors.white,
    ),
    displaySmall: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w400,
      fontSize: 24,
      color: Colors.white,
    ),
    headlineLarge: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w700,
      fontSize: 22,
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w500,
      fontSize: 20,
      color: Colors.white,
    ),
    headlineSmall: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w400,
      fontSize: 18,
      color: Colors.white,
    ),
    titleLarge: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w600,
      fontSize: 18,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w500,
      fontSize: 16,
      color: Colors.white,
    ),
    titleSmall: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w300,
      fontSize: 14,
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w300,
      fontSize: 12,
      color: Colors.white,
    ),
    labelLarge: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w600,
      fontSize: 16,
      color: Colors.white,
    ),
    labelMedium: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w500,
      fontSize: 14,
      color: Colors.white,
    ),
    labelSmall: TextStyle(
      fontFamily: 'iosevka',
      fontWeight: FontWeight.w400,
      fontSize: 12,
      color: Colors.white,
    ),
  ),
);
