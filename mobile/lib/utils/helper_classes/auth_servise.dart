import '/exports.dart';
import 'package:github_sign_in_plus/github_sign_in_plus.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signInWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Error signing in with email: $e');
      return null;
    }
  }

  Future<User?> signInWithGitHub(BuildContext context) async {
    await dotenv.load(fileName: ".env");
    final GitHubSignIn gitHubSignIn = GitHubSignIn(
      clientId: dotenv.env['GIT_CLIENT_ID'] ?? '',
      clientSecret: dotenv.env['GIT_CLIENT_SECRET'] ?? '',
      redirectUrl: 'https://it-planet-1.firebaseapp.com/__/auth/handler',
      title: 'Вход через Github',
      centerTitle: false,
    );

    var result = await gitHubSignIn.signIn(context);
    switch (result.status) {
      case GitHubSignInResultStatus.ok:
        print(result.token);

        if (result.token != null) {
          final OAuthCredential credential =
              GithubAuthProvider.credential(result.token!);
          final UserCredential userCredential =
              await _auth.signInWithCredential(credential);
          return userCredential.user;
        } else {
          print("GitHub sign-in failed, token is null");
          return null; // или обработка ошибки по вашему усмотрению
        }

      case GitHubSignInResultStatus.cancelled:
      case GitHubSignInResultStatus.failed:
        print(result.errorMessage);
        return null;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<bool> isEmailRegistered(String email) async {
    try {
      final methods = await _auth.fetchSignInMethodsForEmail(email);
      return methods.isNotEmpty;
    } catch (e) {
      print('Error checking email registration: $e');
      return false;
    }
  }

  Future<User?> signUpWithEmail(String email, String password) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      print('Error signing up with email: $e');
      return null;
    }
  }

  Future<User?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    return userCredential.user;
  }

  Future<void> sendEmailVerification() async {
    User? user = _auth.currentUser;
    if (user != null && !user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  User? getCurrentUser() {
    return _auth.currentUser;
  }
}
