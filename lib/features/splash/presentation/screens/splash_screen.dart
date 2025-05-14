import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:six_jar/core/constants/app_text_constants.dart';
import 'package:six_jar/core/constants/app_router_constants.dart';
import 'package:six_jar/core/theme/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      // on boarding screen
      GoRouter.of(
        context,
      ).pushReplacementNamed(AppRouteConstants.onBoarding.name);
    });

    super.initState();
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
