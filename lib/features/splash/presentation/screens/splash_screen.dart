import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:six_jar/core/constants/app_db_constants.dart';
import 'package:six_jar/core/constants/app_text_constants.dart';
import 'package:six_jar/core/constants/app_router_constants.dart';
import 'package:six_jar/core/theme/app_colors.dart';
import 'package:six_jar/features/splash/presentation/bloc/app_version_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // Trigger fetching app version
    context.read<AppVersionBloc>().add(FetchAppVersionEvent());

    // navigate screen logic
    navigateScreen(context);

    super.initState();
  }

  // Navigate Screen Logic
  Future<void> navigateScreen(BuildContext context) async {
  await Future.delayed(const Duration(seconds: 2));

  final hiveOnBoardingBox = Hive.box(AppDbConstants.hiveOnBoardingBox);
  final userOnBoardingStatus = hiveOnBoardingBox.get(
    AppDbConstants.isOnBoardedKey,
    defaultValue: false,
  );

  final hiveOnCurrencyBox = Hive.box(AppDbConstants.hiveCurrencyBox);
  final userCurrencySelectedStatus = hiveOnCurrencyBox.get(
    AppDbConstants.isCurrencySelectedKey,
    defaultValue: false,
  );

  final hiveOnAuthBox = Hive.box(AppDbConstants.hiveAuthBox);
  final userIsLoggedInStatus = hiveOnAuthBox.get(
    AppDbConstants.isLoggedInKey,
    defaultValue: false,
  );

  if (!userOnBoardingStatus) {
    GoRouter.of(context).pushReplacementNamed(AppRouteConstants.onBoarding.name);
  } else if (!userCurrencySelectedStatus) {
    GoRouter.of(context).pushReplacementNamed(AppRouteConstants.currencySelect.name);
  } else if (!userIsLoggedInStatus) {
    GoRouter.of(context).pushReplacementNamed(AppRouteConstants.authLogin.name);
  } else {
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
            BlocBuilder<AppVersionBloc, AppVersionState>(
              builder: (context, state) {
                String versionText = '';
                if (state is AppVersionLoaded) {
                  versionText = state.version;
                }
                return Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "${AppTextConstants.appVersionText} $versionText",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
