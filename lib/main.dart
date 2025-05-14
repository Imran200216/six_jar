import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:six_jar/core/di/injectable.dart';
import 'package:six_jar/core/router/app_router.dart';
import 'package:six_jar/core/theme/app_theme.dart';
import 'package:six_jar/features/on_boarding/presentation/bloc/on_boarding_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Injectables
  configureDependencies();

  // Device Orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // On Boarding Bloc
        BlocProvider(create: (context) => getIt<OnBoardingBloc>()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter,
            title: 'Six Jar',
            theme: AppTheme.lightTheme,
          );
        },
      ),
    );
  }
}
