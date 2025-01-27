import '/exports.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final String theme = await Preferences.getAppTheme();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ThemeProvider(theme),
        ),
        ChangeNotifierProvider(create: (_) => BottomNavBarIndexProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var mySystemTheme = SystemUiOverlayStyle.dark.copyWith(
      systemNavigationBarColor: //Theme.of(context).scaffoldBackgroundColor
          Theme.of(context).brightness == Brightness.dark
              ? const Color(0xFF141318)
              : Colors.white,
    );
    SystemChrome.setSystemUIOverlayStyle(mySystemTheme);
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Помощник старосты',
          theme: themeProvider.themeData,
          initialRoute: '/home',
          routes: <String, WidgetBuilder>{
            '/home': (BuildContext context) => MyHomePage(),
          },
          home: MyHomePage(),
        );
      },
    );
  }
}
