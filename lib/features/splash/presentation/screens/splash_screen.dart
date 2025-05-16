import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:six_jar/core/constants/app_text_constants.dart';
import 'package:six_jar/core/constants/app_router_constants.dart';
import 'package:six_jar/core/di/injectable.dart';
import 'package:six_jar/core/service/hive_service.dart';
import 'package:six_jar/core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // navigate screen logic
    navigateScreen();

    super.initState();
  }

  // Navigate Screen Logic
  Future<void> navigateScreen() async {
    // timer
    await Future.delayed(const Duration(seconds: 2));

    // Hive status
    final hiveService = getIt<HiveService>();
    final isOnBoardingCompleted = hiveService.isOnBoardingCompleted;
    final isAuthLoggedIn = hiveService.isLoggedIn;
    final isCurrencySelected = hiveService.isCurrencySelected;

    if (!isOnBoardingCompleted) {
      // On Boarding Screen
      GoRouter.of(
        context,
      ).pushReplacementNamed(AppRouteConstants.onBoarding.name);
    } else if (!isAuthLoggedIn) {
      // Auth Login Screen
      GoRouter.of(
        context,
      ).pushReplacementNamed(AppRouteConstants.authLogin.name);
    } else if (!isCurrencySelected) {
      // Currency Select Screen
      GoRouter.of(
        context,
      ).pushReplacementNamed(AppRouteConstants.currencySelect.name);
    } else {
      // Home Screen
      GoRouter.of(context).pushReplacementNamed(AppRouteConstants.home.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        margin: EdgeInsets.only(bottom: 30.h),
        child: Stack(
          children: [
            // App name
            Align(
              alignment: Alignment.center,
              child: Text(
                AppTextConstants.appNameText,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                  fontSize: 22.sp,
                ),
              ),
            ),

            // App Version
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "${AppTextConstants.appVersionText} 1.0.0",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
