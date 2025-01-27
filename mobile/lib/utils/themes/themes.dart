import '/exports.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.purple,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF9146FF),
    brightness: Brightness.light,
    secondaryContainer: const Color(0xFFF5EDFF),
    primaryContainer: const Color(0xFFF5EDFF),
    onTertiaryFixed: Colors.black,
    onTertiaryFixedVariant: Colors.white
  ),
  scaffoldBackgroundColor: Colors.white,
  primaryColor: const Color(0xFF9146FF),
  /* textTheme: const TextTheme(
    displayLarge: TextStyle(fontFamily: 'TTNorms'),
    displayMedium: TextStyle(fontFamily: 'TTNorms'),
    displaySmall: TextStyle(fontFamily: 'TTNorms'),
    headlineLarge: TextStyle(fontFamily: 'TTNorms'),
    headlineMedium: TextStyle(fontFamily: 'TTNorms'),
    headlineSmall: TextStyle(fontFamily: 'TTNorms'),
    titleLarge: TextStyle(fontFamily: 'TTNorms'),
    titleMedium: TextStyle(fontFamily: 'TTNorms'),
    titleSmall: TextStyle(fontFamily: 'TTNorms'),
    bodyLarge: TextStyle(fontFamily: 'TTNorms'),
    bodyMedium: TextStyle(fontFamily: 'TTNorms'),
    bodySmall: TextStyle(fontFamily: 'TTNorms'),
    labelLarge: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      fontFamily: 'TTNorms',
    ),
    labelMedium: TextStyle(fontFamily: 'TTNorms'),
    labelSmall: TextStyle(fontFamily: 'TTNorms'),
  ), */
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.purple,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF6700FF),
    brightness: Brightness.dark,
    secondaryContainer: const Color(0xFF222029),
    error: const Color.fromARGB(255, 207, 58, 48),
    primaryContainer: const Color(0xFFF5EDFF),
    onTertiaryFixed: Colors.white,
    onTertiaryFixedVariant: Colors.black
  ),
  scaffoldBackgroundColor: const Color(0xFF141318),
  primaryColor: const Color(0xFF6700FF),
  /* textTheme: const TextTheme(
    displayLarge: TextStyle(fontFamily: 'TTNorms'),
    displayMedium: TextStyle(fontFamily: 'TTNorms'),
    displaySmall: TextStyle(fontFamily: 'TTNorms'),
    headlineLarge: TextStyle(fontFamily: 'TTNorms'),
    headlineMedium: TextStyle(fontFamily: 'TTNorms'),
    headlineSmall: TextStyle(fontFamily: 'TTNorms'),
    titleLarge: TextStyle(fontFamily: 'TTNorms'),
    titleMedium: TextStyle(fontFamily: 'TTNorms'),
    titleSmall: TextStyle(fontFamily: 'TTNorms'),
    bodyLarge: TextStyle(fontFamily: 'TTNorms'),
    bodyMedium: TextStyle(fontFamily: 'TTNorms'),
    bodySmall: TextStyle(fontFamily: 'TTNorms'),
    labelLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w700,
      fontFamily: 'TTNorms',
    ),
    labelMedium: TextStyle(fontFamily: 'TTNorms'),
    labelSmall: TextStyle(fontFamily: 'TTNorms'),
  ), */
);
