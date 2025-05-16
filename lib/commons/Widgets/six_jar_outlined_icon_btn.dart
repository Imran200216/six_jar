import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:six_jar/core/helper/app_haptics_helper.dart';
import 'package:six_jar/core/theme/app_colors.dart';

class SixJarOutlinedIconBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? iconData;
  final String? svgAssetPath;
  final String label;
  final double? width;
  final double? height;
  final double? btnFontSize;
  final double iconSize;
  final Color? borderColor;

  const SixJarOutlinedIconBtn({
    super.key,
    required this.onPressed,
    required this.label,
    this.iconData,
    this.svgAssetPath,
    this.isLoading = false,
    this.width,
    this.height,
    this.btnFontSize,
    this.iconSize = 18.0,
    this.borderColor,
  });

  // 🔔 Add a haptic-triggering wrapper
  void _handleTap() {
    AppHapticHelper.heavyImpact();
    if (onPressed != null) {
      onPressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget buildIcon() {
      if (isLoading) {
        return SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator.adaptive(
            strokeWidth: 2,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.textPrimary,
            ),
          ),
        );
      } else if (svgAssetPath != null) {
        return SvgPicture.asset(
          svgAssetPath!,
          width: iconSize.h,
          height: iconSize.h,
          colorFilter: const ColorFilter.mode(
            AppColors.textPrimary,
            BlendMode.srcIn,
          ),
        );
      } else if (iconData != null) {
        return Icon(iconData, color: AppColors.textPrimary, size: iconSize.h);
      } else {
        return const SizedBox.shrink();
      }
    }

    return SizedBox(
      width: width,
      height: height ?? 48,
      child: OutlinedButton.icon(
        onPressed: isLoading ? null : _handleTap, // 👈 Use wrapper
        icon: buildIcon(),
        label: Text(
          isLoading ? "Loading..." : label,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
            fontSize: btnFontSize ?? 13.sp,
          ),
        ),
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: borderColor ?? AppColors.btnBorderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.w),
          ),
          foregroundColor: AppColors.textPrimary,
        ),
      ),
    );
  }
}
