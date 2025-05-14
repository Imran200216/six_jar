import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:six_jar/core/theme/app_colors.dart';

class OnBoarding extends StatelessWidget {
  final String onBoardingTitleText;
  final String onBoardingSubTitleText;
  final String onBoardingSvgPath;
  const OnBoarding({
    super.key,
    required this.onBoardingTitleText,
    required this.onBoardingSubTitleText,
    required this.onBoardingSvgPath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // On Boarding Title
          Text(
            onBoardingTitleText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              fontSize: 20,
            ),
          ),

          const SizedBox(height: 30),

          // On Boarding Sub title
          Text(
            onBoardingSubTitleText,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),

          const Spacer(flex: 1),

          // On Boarding img
          SvgPicture.asset(
            onBoardingSvgPath,
            height: 0.26.sh,
            fit: BoxFit.contain,
          ),

          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
