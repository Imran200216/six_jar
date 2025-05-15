import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:six_jar/core/helper/app_haptics_helper.dart';
import 'package:six_jar/core/theme/app_colors.dart';

class SixJarAddExpenseFilledBtn extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? iconData;
  final String? svgAssetPath;
  final String label;
  final double? width;
  final double? height;
  final double? btnFontSize;
  final double iconSize;
  final Color? backgroundColor;
  final Color? contentColor;

  const SixJarAddExpenseFilledBtn({
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
    this.backgroundColor,
    this.contentColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color bgColor = backgroundColor ?? AppColors.primary;
    final Color fgColor = contentColor ?? Colors.white;

    Widget buildIcon() {
      if (isLoading) {
        return SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator.adaptive(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(fgColor),
          ),
        );
      } else if (svgAssetPath != null) {
        return SvgPicture.asset(
          svgAssetPath!,
          width: iconSize.h,
          height: iconSize.h,
          colorFilter: ColorFilter.mode(fgColor, BlendMode.srcIn),
        );
      } else if (iconData != null) {
        return Icon(iconData, color: fgColor, size: iconSize.h);
      } else {
        return const SizedBox.shrink();
      }
    }

    return SizedBox(
      width: width,
      height: height ?? 48,
      child: ElevatedButton.icon(
        onPressed: isLoading
            ? null
            : () {
                AppHapticHelper.heavyImpact();
                onPressed?.call();
              },
        icon: buildIcon(),
        label: Text(
          isLoading ? "Loading..." : label,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: fgColor,
            fontWeight: FontWeight.w500,
            fontSize: btnFontSize ?? 13.sp,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: fgColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.w),
          ),
        ),
      ),
    );
  }
}
