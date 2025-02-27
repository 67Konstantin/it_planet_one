import '/exports.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AuthService _authService = AuthService(); // Создаем экземпляр

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).padding.top * 0.0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '${_authService.getCurrentUser()?.email ?? "Не авторизован"}', // Используем экземпляр
            ),
            // ElevatedButton(
            //   child: Text('Перейти на регистрацию'),
            //   onPressed: () {
            //     Navigator.pushNamed(context, '/sign_in');
            //   },
            // ),
            SizedBox(height: 16),

            CustomButton(
              text: "Просто кнопка",
              onPressed: () {
                print("Нажата кнопка!");
              },
              textStyle: TextStyle(
                fontSize: 24,
              ),
              isDashed: true,
            ),
            SizedBox(height: 24),
            CustomButton(
              text: "Регистрация",
              onPressed: () {
                Navigator.pushNamed(context, '/sign_in');

              },
              textStyle: TextStyle(
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
