import 'package:go_router/go_router.dart';
import 'package:six_jar/core/constants/app_router_constants.dart';
import 'package:six_jar/features/auth/presentation/screens/auth_forget_password_screen.dart';
import 'package:six_jar/features/auth/presentation/screens/auth_login_screen.dart';
import 'package:six_jar/features/auth/presentation/screens/auth_sign_up_screen.dart';
import 'package:six_jar/features/home/presentation/screens/home_screen.dart';
import 'package:six_jar/features/on_boarding/presentation/screens/on_boarding_screen.dart';
import 'package:six_jar/features/splash/presentation/screens/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  // inital route
  initialLocation: "/splash",

  routes: [
    // splash screen
    GoRoute(
      path: "/splash",
      name: AppRouteConstants.splash.name,
      builder: (context, state) => SplashScreen(),
    ),

    // on boarding screen
    GoRoute(
      path: "/onBoarding",
      name: AppRouteConstants.onBoarding.name,
      builder: (context, state) => OnBoardingScreen(),
    ),

    // auth login screen
    GoRoute(
      path: "/authLogin",
      name: AppRouteConstants.authLogin.name,
      builder: (context, state) => AuthLoginScreen(),
    ),

    // auth sign up screen
    GoRoute(
      path: "/authSignUp",
      name: AppRouteConstants.authSignUp.name,
      builder: (context, state) {
        return AuthSignUpScreen();
      },
    ),

    // auth forget password screen
    GoRoute(
      path: "/authForgetPassword",
      name: AppRouteConstants.authForgetPassword.name,
      builder: (context, state) {
        return AuthForgetPasswordScreen();
      },
    ),

    // home screen
    GoRoute(
      path: "/home",
      name: AppRouteConstants.home.name,
      builder: (context, state) {
        return HomeScreen();
      },
    ),
  ],
);
