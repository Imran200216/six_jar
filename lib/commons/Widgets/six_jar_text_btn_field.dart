import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:six_jar/core/helper/app_haptics_helper.dart';
import 'package:six_jar/core/theme/app_colors.dart';


class SixJarTextBtn extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SixJarTextBtn({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        AppHapticHelper.heavyImpact();
        onPressed();
      },
      child: Text(
        text,
        style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: AppColors.primary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}
