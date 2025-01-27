import '/exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Список экранов для каждой вкладки
  static const List<Widget> _screens = <Widget>[
    MainScreen(),
    TimeTableScreen(),
    Center(child: Text('3')),
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
