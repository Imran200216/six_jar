import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:six_jar/core/helper/app_haptics_helper.dart';
import 'package:six_jar/core/theme/app_colors.dart';

class SixJarTextBtn extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double fontSize;
  final FontWeight fontWeight;
  final EdgeInsetsGeometry? padding;

  const SixJarTextBtn({
    super.key,
    required this.text,
    required this.onPressed,
    this.fontSize = 14, // default font size
    this.fontWeight = FontWeight.w500, // default weight
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        AppHapticHelper.heavyImpact();
        onPressed();
      },
      style: TextButton.styleFrom(
        padding: padding,
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: AppColors.primary,
              fontSize: fontSize.sp,
              fontWeight: fontWeight,
            ),
      ),
    );
  }
}
