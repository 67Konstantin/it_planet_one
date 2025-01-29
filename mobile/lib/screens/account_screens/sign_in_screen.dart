import '/exports.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Вход')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextInput(
              labelText: 'Электронная почта',
              controller: _emailController,
              isRequired: true,
              validationConditions: [
                (value) =>
                    _isValidEmail(value) ? null : 'Неверный формат email',
              ],
            ),
            SizedBox(height: 10),
            CustomTextInput(
              labelText: 'Пароль',
              controller: _passwordController,
              isPassword: true,
              isRequired: true,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _signIn,
                    child: Text('Войти по Email'),
                  ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/sign_up');
              },
              child: Text('Зарегистрироваться по Email'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _signInWithGoogle,
              child: Text('Войти через Google'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _signInWithGitHub,
              child: Text('Войти через GitHub'),
            ),
            SizedBox(height: 20),
            Text(
                '${_authService.getCurrentUser()?.displayName ?? "Не авторизован"}'),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Выход'),
                    content: Text('Вы уверены, что хотите выйти?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Отмена'),
                      ),
                      TextButton(
                        onPressed: () async {
                          Navigator.pop(context);
                          await _authService.signOut();
                          Navigator.pushReplacementNamed(context, '/sign_in');
                        },
                        child: Text('Выйти'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('Выйти'),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _signIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showError('Пожалуйста, заполните все поля');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    final user = await _authService.signInWithEmail(email, password);

    setState(() {
      _isLoading = false;
    });

    if (user != null) {
      if (user.emailVerified) {
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        _showError('Пожалуйста, подтвердите свою почту перед входом.');
      }
    } else {
      _showError('Неверный email или пароль.');
    }
  }

  Future<void> _signInWithGoogle() async {
    setState(() {
      _isLoading = true;
    });

    final user = await _authService.signInWithGoogle();

    setState(() {
      _isLoading = false;
    });

    if (user != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      _showError('Ошибка входа через Google.');
    }
  }

  Future<void> _signInWithGitHub() async {
    setState(() {
      _isLoading = true;
    });

    final user = await _authService.signInWithGitHub(context);

    setState(() {
      _isLoading = false;
    });

    if (user != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      _showError('Ошибка входа через GitHub.');
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Ошибка'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('ОК'),
          ),
        ],
      ),
    );
  }
}
