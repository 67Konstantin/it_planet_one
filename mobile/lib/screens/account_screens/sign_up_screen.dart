import '/exports.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _authService = AuthService();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
    );
  }

  Widget _body() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextInput(
              labelText: 'Электронная почта',
              controller: _emailController,
              isRequired: true,
              validationConditions: [
                (value) => _isValidEmail(value) ? null : 'Неверный формат email',
              ],
            ),
            SizedBox(height: 16),
            CustomTextInput(
              labelText: 'Пароль',
              controller: _passwordController,
              isPassword: true,
              isRequired: true,
              validationConditions: [
                (value) => _isPasswordStrong(value)
                    ? null
                    : 'Пароль должен содержать минимум 6 символов, включая буквы и цифры',
              ],
            ),
            SizedBox(height: 16),
            CustomTextInput(
              labelText: 'Подтвердите пароль',
              controller: _confirmPasswordController,
              isPassword: true,
              isRequired: true,
              validationConditions: [
                (value) => value == _passwordController.text
                    ? null
                    : 'Пароли не совпадают',
              ],
            ),
            SizedBox(height: 16),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _signUp,
                    child: Text('Зарегистрироваться'),
                  ),
          ],
        ),
      ),
    );
  }

  Future<void> _signUp() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    final confirmPassword = _confirmPasswordController.text.trim();

    if (email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      _showError('Пожалуйста, заполните все поля');
      return;
    }

    if (password != confirmPassword) {
      _showError('Пароли не совпадают');
      return;
    }

    if (!_isPasswordStrong(password)) {
      _showError('Пароль должен содержать минимум 6 символов, включая буквы и цифры');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Проверка, существует ли уже аккаунт с таким email
    final emailExists = await _authService.isEmailRegistered(email);
    if (emailExists) {
      setState(() {
        _isLoading = false;
      });
      _showError('Аккаунт с таким email уже существует');
      return;
    }

    final user = await _authService.signUpWithEmail(email, password);
    setState(() {
      _isLoading = false;
    });

    if (user != null) {
      await _authService.sendEmailVerification();
      _showSuccess('Регистрация успешна! Подтвердите свой email, перейдя по ссылке в письме.');
      Navigator.pushReplacementNamed(context, '/login');
    } else {
      _showError('Ошибка регистрации. Попробуйте ещё раз');
    }
  }

  bool _isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  bool _isPasswordStrong(String password) {
    final passwordRegex = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{6,}$');
    return passwordRegex.hasMatch(password);
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

  void _showSuccess(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Успешно'),
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
