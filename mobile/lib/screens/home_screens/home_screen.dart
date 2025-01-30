import '/exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Список экранов для каждой вкладки
  static const List<Widget> _screens = <Widget>[
    // Замените ниже на настоящие экраны:
    // MainScreen(),
    // TimeTableScreen(),
    MainScreen(),
    SecondScreen(),
    Center(child: Text('Чат')),
    Center(child: Text('HackTime')),
    Center(child: Text('Профиль')),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex =
        context.watch<BottomNavBarIndexProvider>().selectedIndex;

    return Scaffold(
      body: _screens[
          selectedIndex], // Выводим экран в зависимости от выбранной вкладки
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
