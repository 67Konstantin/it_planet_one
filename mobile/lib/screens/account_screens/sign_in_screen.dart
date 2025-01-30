import '/exports.dart';
import 'dart:ui';

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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Первый круг (синий)
          Positioned(
            top: -size.width * 0.2,
            left: -size.height * 0.1,
            child: Container(
              width: size.width * 1.2,
              height: size.width * 1.5,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.primary.withAlpha(50), // Color(0xFF0077FF).withOpacity(0.3),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          // Второй круг (зелёный)
          Positioned(
            right: -size.width * 0.25,
            bottom: size.height * 0.1,
            child: Container(
              width: size.width * 0.8,
              height: size.width * 0.8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).colorScheme.secondary.withAlpha(80),// const Color(0xFF00FF77).withOpacity(0.3),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
                child: Container(color: Colors.transparent),
              ),
            ),
          ),
          // Основной контент
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Логотип
                  // Container(
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     color: Colors.transparent,
                  //   ),
                    // child: ClipOval(
                      // child: Image.asset(
                      //   'assets/logo.png',
                      //   height: 100,
                      //   width: 100,
                      //   fit: BoxFit.cover,
                      // ),
                       SvgPicture.asset(
                          'assets/logo.svg',
                          height: 100 ,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                    // ),
                  // ),
                  
                  const SizedBox(height: 32),
                  Text(
                    'Войдите, чтобы продолжить',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      // color: Colors.white,
                      letterSpacing: 1,
                      height: 1.5,
                      color: Theme.of(context).colorScheme.primary.withAlpha(200),
                    ),
                  ),
                  const SizedBox(height: 24),
                  CustomTextInput(
                    labelText: 'Почта',
                    controller: _emailController,
                    isRequired: true,
                    validationConditions: [
                      (value) =>
                          _isValidEmail(value) ? null : 'Неверный формат email',
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomTextInput(
                    labelText: 'Пароль',
                    controller: _passwordController,
                    isPassword: true,
                    isRequired: true,
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        changeTheme(context);
                      },
                      child: Text(
                        'Забыли пароль',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/sign_up');
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Theme.of(context).colorScheme.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Регистрация',
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'или войдите с помощью',
                    style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).colorScheme.primary.withAlpha(200),
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _signInWithGoogle,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                        icon: SvgPicture.asset(
                          'assets/icons/google_icon.svg',
                          height: 24,
                        ),
                        label: const Text('Google'),
                      ),
                      ElevatedButton.icon(
                        onPressed: _signInWithGitHub,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.0),
                          ),
                        ),
                        icon: SvgPicture.asset(
                          'assets/icons/github_icon.svg',
                          color: Colors.white,
                          height: 24,
                        ),
                        label: const Text('GitHub'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
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
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}\$');
    return emailRegex.hasMatch(email);
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ошибка'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('ОК'),
          ),
        ],
      ),
    );
  }
}
