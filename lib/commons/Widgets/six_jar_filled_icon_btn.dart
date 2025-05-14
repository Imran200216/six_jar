import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:six_jar/core/theme/app_colors.dart';

class SixJarFilledIconBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData icon;
  final String label;
  final double? width;
  final double? height;
  final double? btnFontSize;

  const SixJarFilledIconBtn({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    this.isLoading = false,
    this.width,
    this.height,
    this.btnFontSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height ?? 48.h,
      child: ElevatedButton.icon(
        onPressed: isLoading ? null : onPressed,
        icon: isLoading
            ? SizedBox(
                width: 20.w,
                height: 20.w,
                child: const CircularProgressIndicator.adaptive(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.background,
                  ),
                ),
              )
            : Icon(icon, color: AppColors.background, size: 18.h),
        label: Text(
          isLoading ? "Loading..." : label,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: AppColors.background,
            fontWeight: FontWeight.w500,
            fontSize: btnFontSize ?? 13.sp,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.w),
          ),
          foregroundColor: AppColors.background,
        ),
      ),
    );
  }
}
