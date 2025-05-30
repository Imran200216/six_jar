import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:six_jar/core/constants/app_assets_constants.dart';
import 'package:six_jar/core/constants/app_text_constants.dart';
import 'package:six_jar/core/theme/app_colors.dart';
import 'package:six_jar/commons/Widgets/six_jar_filled_icon_btn.dart';
import 'package:six_jar/commons/Widgets/six_jar_outlined_icon_btn.dart';

void showSixJarLogoutBottomSheet({
  required BuildContext context,
  required VoidCallback onConfirmLogout,
}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: AppColors.transparentColor,
    isScrollControlled: true, 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (context) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        // Remove the fixed-height SizedBox
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 30.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Lottie Animation - Adjust size to prevent overflow
              Lottie.asset(
                AppAssetsConstants.logOutLottie,
                height: 240.h, // Reduced from 280.h
                width: 240.w, // Reduced from 280.w
                fit: BoxFit.cover,
                animate: true,
              ),

              // Title
              Text(
                AppTextConstants.logoutTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 12.h),

              // Description
              Text(
                AppTextConstants.logoutSubTitle,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 30.h),

              // Logout Button
              SixJarFilledIconBtn(
                width: double.infinity,
                height: 34.h,
                onPressed: onConfirmLogout,
                icon: Icons.logout,
                label: AppTextConstants.logout,
              ),

              SizedBox(height: 12.h),

              // Cancel Button
              SixJarOutlinedIconBtn(
                width: double.infinity,
                borderColor: AppColors.textSecondary,
                height: 34.h,
                onPressed: () {
                  // cancel
                  GoRouter.of(context).pop();
                },
                iconData: Icons.cancel_outlined,
                label: AppTextConstants.cancelText,
              ),
            ],
          ),
        ),
      );
    },
  );
}
