import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:six_jar/commons/Widgets/six_jar_filled_icon_btn.dart';
import 'package:six_jar/commons/Widgets/six_jar_outlined_icon_btn.dart';
import 'package:six_jar/commons/bloc/connectivity_bloc.dart';
import 'package:six_jar/core/constants/app_assets.constants.dart';
import 'package:six_jar/core/constants/app_text_constants.dart';
import 'package:six_jar/core/constants/app_router_constants.dart';
import 'package:six_jar/core/di/injectable.dart';
import 'package:six_jar/core/helper/app_logger_helper.dart';
import 'package:six_jar/core/helper/app_snack_bar_helper.dart';
import 'package:six_jar/core/service/hive_service.dart';
import 'package:six_jar/core/theme/app_colors.dart';
import 'package:six_jar/features/on_boarding/presentation/bloc/on_boarding_bloc.dart';
import 'package:six_jar/features/on_boarding/presentation/widgets/on_boarding.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // On Boarding Bloc
        BlocProvider(create: (context) => OnBoardingBloc()),

        // Internect Connectivity Bloc
        BlocProvider(create: (context) => ConnectivityBloc()),
      ],
      child: MultiBlocListener(
        listeners: [
          // Internet Connectivity Listener
          BlocListener<ConnectivityBloc, ConnectivityState>(
            listener: (context, state) {
              if (state is ConnectivitySuccess) {
                // success snackbar
                AppSnackBarHelper.showSnackBar(
                  context: context,
                  message: AppTextConstants.internetSuccessText,
                  isSuccess: true,
                  customIcon: Icons.signal_cellular_4_bar_outlined,
                );
              } else if (state is ConnectivityFailure) {
                // failure snackbar
                AppSnackBarHelper.showSnackBar(
                  context: context,
                  message: AppTextConstants.internetFailureText,
                  isSuccess: false,
                  customIcon: Icons.mobiledata_off_sharp,
                );
              }
            },
          ),
        ],
        child: _OnBoardingScreenContent(pageController: pageController),
      ),
    );
  }
}

class _OnBoardingScreenContent extends StatefulWidget {
  final PageController pageController;

  const _OnBoardingScreenContent({required this.pageController});

  @override
  State<_OnBoardingScreenContent> createState() =>
      _OnBoardingScreenContentState();
}

class _OnBoardingScreenContentState extends State<_OnBoardingScreenContent> {
  @override
  void initState() {
    super.initState();

    widget.pageController.addListener(() {
      final currentPage = widget.pageController.page?.round() ?? 0;
      final bloc = context.read<OnBoardingBloc>();
      final state = bloc.state;

      if (state is OnBoardingInitial && state.currentPage != currentPage) {
        bloc.add(PageChangedEvent(currentPage));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomSheet: Container(
        height: 200.h,
        decoration: BoxDecoration(color: AppColors.background),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            spacing: 12.h,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              BlocBuilder<OnBoardingBloc, OnBoardingState>(
                builder: (context, state) {
                  return SmoothPageIndicator(
                    controller: widget.pageController,
                    count: 3,
                    effect: WormEffect(
                      dotColor: Colors.grey.shade400,
                      activeDotColor: AppColors.primary,
                      dotHeight: 5.h,
                      dotWidth: 14.w,
                    ),
                  );
                },
              ),
              SizedBox(height: 10.h),
              SixJarOutlinedIconBtn(
                height: 38.h,
                width: double.infinity,
                onPressed: () {
                  widget.pageController.jumpToPage(2);
                },
                iconData: Icons.loop_outlined,
                label: AppTextConstants.skipText,
              ),
              BlocBuilder<OnBoardingBloc, OnBoardingState>(
                builder: (context, state) {
                  final currentPage = state is OnBoardingInitial
                      ? state.currentPage
                      : 0;

                  return SixJarFilledIconBtn(
                    height: 38.h,
                    width: double.infinity,
                    onPressed: () async {
                      if (currentPage < 2) {
                        widget.pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        // Hive OnBoarding Status
                        final hiveService = getIt<HiveService>();
                        await hiveService.setOnBoardingCompleted(true);

                        // Logger
                        AppLoggerHelper.logInfo(
                          "✅ Onboarding completed status saved in Hive.",
                        );

                        // Login Screen
                        GoRouter.of(context).pushReplacementNamed(
                          AppRouteConstants.authLogin.name,
                        );
                      }
                    },
                    icon: currentPage < 2
                        ? Icons.skip_next_outlined
                        : Icons.login,
                    label: currentPage < 2 ? "Continue" : "Get Started",
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: PageView(
          onPageChanged: (value) {
            context.read<OnBoardingBloc>().add(PageChangedEvent(value));
          },
          controller: widget.pageController,
          children: [
            // On Boarding First Screen
            OnBoarding(
              onBoardingTitleText: AppTextConstants.onBoardingFirstTitleText,
              onBoardingSubTitleText:
                  AppTextConstants.onBoardingFirstSubTitleText,
              onBoardingSvgPath: AppAssetsConstants.onBoardingFirstImg,
            ),

            // On Boarding Second Screen
            OnBoarding(
              onBoardingTitleText: AppTextConstants.onBoardingSecondTitleText,
              onBoardingSubTitleText:
                  AppTextConstants.onBoardingSecondSubTitleText,
              onBoardingSvgPath: AppAssetsConstants.onBoardingSecondImg,
            ),

            // On Boarding Third Screen
            OnBoarding(
              onBoardingTitleText: AppTextConstants.onBoardingThirdTitleText,
              onBoardingSubTitleText:
                  AppTextConstants.onBoardingThirdSubTitleText,
              onBoardingSvgPath: AppAssetsConstants.onBoardingThirdImg,
            ),
          ],
        ),
      ),
    );
  }
}
