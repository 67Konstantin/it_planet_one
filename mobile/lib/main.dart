import 'package:firebase_core/firebase_core.dart';

import '/exports.dart';
import 'firebase_options.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  final String theme = await Preferences.getAppTheme();
  await dotenv.load(fileName: ".env");
  // final supabaseApiKey = dotenv.env['API_KEY'] ?? '';
  // final String supabaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  // await Supabase.initialize(
  //   url: supabaseUrl,
  //   anonKey: supabaseApiKey,
  // );

await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
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
          title: 'HackDev',
          theme: themeProvider.themeData,
          initialRoute: '/sign_in',
          routes: <String, WidgetBuilder>{
            '/home': (BuildContext context) => MyHomePage(),
            '/sign_in': (BuildContext context) => SignInScreen(),
            '/sign_up': (BuildContext context) => SignUpScreen(),
            '/my_account': (BuildContext context) => MyAccountScreen(),
          },
          home: MyHomePage(),
        );
      },
    );
  }
}
