import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:six_jar/core/theme/app_colors.dart';

class AuthDividerContent extends StatelessWidget {
  final String dividerTextContent;
  const AuthDividerContent({super.key, required this.dividerTextContent});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Left Divider
        Expanded(
          child: Divider(
            color: AppColors.textFieldBorderColor,
            thickness: 1.2.w,
          ),
        ),

        // Spacing between divider and text
        SizedBox(width: 12.w),

        // Center Text
        Text(
          dividerTextContent,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.w500,
            fontSize: 12.sp,
          ),
        ),

        // Spacing between text and divider
        SizedBox(width: 12.w),

        // Right Divider
        Expanded(
          child: Divider(
            color: AppColors.textFieldBorderColor,
            thickness: 1.2.w,
          ),
        ),
      ],
    );
  }
}
