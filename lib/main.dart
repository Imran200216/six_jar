import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:six_jar/commons/bloc/connectivity_bloc.dart';
import 'package:six_jar/core/di/injectable.dart';
import 'package:six_jar/core/router/app_router.dart';
import 'package:six_jar/core/service/hive_service.dart';
import 'package:six_jar/core/theme/app_theme.dart';
import 'package:six_jar/features/currency_select/presentation/bloc/currency_selected_bloc.dart';
import 'package:six_jar/features/on_boarding/presentation/bloc/on_boarding_bloc.dart';
import 'package:six_jar/features/splash/presentation/bloc/app_version_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Injectables
  configureDependencies();

  // Get the HiveService instance from GetIt
  final hiveService = getIt<HiveService>();

  // Initialize Hive boxes
  await hiveService.init();

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
        // App Version Bloc 
        BlocProvider(create: (context) => getIt<AppVersionBloc>(),),

        // On Boarding Bloc
        BlocProvider(create: (context) => getIt<OnBoardingBloc>()),

        // Currency Selected Bloc
        BlocProvider(create: (context) => getIt<CurrencySelectedBloc>()),

        // Connectivity Bloc
        BlocProvider(create: (context) => getIt<ConnectivityBloc>()),
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
