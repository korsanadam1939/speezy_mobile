import 'package:go_router/go_router.dart';
import 'package:speezy_mobile/rolegame/presentation/pages/role_page.dart';
import 'package:speezy_mobile/views/login/forgetpassword.dart';
import 'package:speezy_mobile/views/login/resetpassword.dart';
import 'package:speezy_mobile/views/pages/game.dart';
import 'package:speezy_mobile/views/pages/home.dart';
import 'package:speezy_mobile/widgets/bottombor.dart';
import 'package:speezy_mobile/views/login/register.dart';
import 'package:speezy_mobile/views/pages/profile.dart';
import 'package:speezy_mobile/wordgame/presentation/pages/word_page.dart';
import '../reading/presentation/pages/reading_page.dart';
import '../viewmodels/auth_viewmodel.dart';
import '../views/login/login.dart';
import '../views/splash/splash.dart';

GoRouter createRouter(AuthViewModel authViewModel) {
  return GoRouter(
    initialLocation: '/splash',
    /*refreshListenable: authViewModel,
    redirect: (context, state) {
      final isLoggedIn = authViewModel.isLoggedIn;
      final loggingIn = state.matchedLocation == '/login';

      if (!isLoggedIn && !loggingIn) return '/login';
      if (isLoggedIn && loggingIn) return '/home';

      return null;
    },*/
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/bottom',
        builder: (context, state) => bottombor(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const Profile(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: '/game',
        builder: (context, state) => const Gamescreen(),
      ),
      GoRoute(
        path: '/forgetpossword',
        builder: (context, state) => const ForgetPasswordScreen(),
      ),
      GoRoute(
        path: '/resetpassword',
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: '/reading',
        builder: (context, state) => const ReadingPage(),
      ),
      GoRoute(
        path: '/wordgame',
        builder: (context, state) => WordPage(),
      ),
      GoRoute(
        path: '/rolegame',
        builder: (context, state) => RolePage(),
      ),

    ],
  );
}
