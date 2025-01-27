import '/exports.dart';
class Preferences {
  static const String _keyAppTheme = 'appTheme';

  // Метод для установки темы
  static Future<void> setAppTheme(String theme) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(_keyAppTheme, theme);
    } catch (e) {
      print("Error setting app theme: $e");
    }
  }

  // Метод для получения темы с проверкой инициализации
  static Future<String> getAppTheme() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? theme = prefs.getString(_keyAppTheme);
      
      // Возвращаем тему, если она уже установлена, или 'dark' по умолчанию
      return theme ?? 'dark';
    } catch (e) {
      print("Error getting app theme: $e");
      
      // В случае ошибки возвращаем тему по умолчанию
      return 'dark';
    }
  }
}
