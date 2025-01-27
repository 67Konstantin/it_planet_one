import '/exports.dart';

class ThemeProvider with ChangeNotifier {
  String _currentTheme;

  ThemeProvider(this._currentTheme);

  ThemeData get themeData {
    return _currentTheme == 'dark' ? darkTheme : lightTheme;
  }

  bool get isDarkTheme {
    return _currentTheme == 'dark';
  }

  Future<void> changeTheme(String newTheme) async {
    _currentTheme = newTheme;
    await Preferences.setAppTheme(newTheme);

    var mySystemTheme = SystemUiOverlayStyle.dark.copyWith(
      systemNavigationBarColor: //Theme.of(context).scaffoldBackgroundColor
          newTheme == 'dark' ? const Color(0xFF141318) : Colors.white,
    );
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);

    notifyListeners();
  }

  Future<void> setTheme(String newTheme) async {
    _currentTheme = newTheme;
    await Preferences.setAppTheme(newTheme);

    var mySystemTheme = SystemUiOverlayStyle.dark.copyWith(
      systemNavigationBarColor: //Theme.of(context).scaffoldBackgroundColor
          newTheme == 'dark' ? const Color(0xFF141318) : Colors.white,
    );
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);

    notifyListeners();
  }
}

void changeTheme(context) async {
  await Provider.of<ThemeProvider>(context, listen: false).changeTheme(
      Provider.of<ThemeProvider>(context, listen: false).themeData == lightTheme
          ? 'dark'
          : 'light');
}
