import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:six_jar/core/helper/app_haptics_helper.dart';
import 'package:six_jar/core/theme/app_colors.dart';

class AuthFooter extends StatelessWidget {
  final String descriptionText;
  final String textBtnTitle;
  final VoidCallback textBtnOnTap;
  const AuthFooter({
    super.key,
    required this.descriptionText,
    required this.textBtnTitle,
    required this.textBtnOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // description Text
        Text(
          descriptionText,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
            fontSize: 13.sp,
          ),
        ),

        // Text btn title
        TextButton(
          onPressed: () {
            AppHapticHelper.heavyImpact();

            textBtnOnTap();
          },
          child: Text(
            textBtnTitle,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: AppColors.primary,
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
