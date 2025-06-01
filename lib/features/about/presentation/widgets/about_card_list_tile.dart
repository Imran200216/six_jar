import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:six_jar/core/theme/app_colors.dart';

class AboutCardListTile extends StatelessWidget {
  final String listTitle;
  final VoidCallback onTap;

  const AboutCardListTile({
    super.key,
    required this.listTitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.btnBorderColor,
            width: 1.6, // border width
          ),
        ),
      ),
      child: ListTile(
        trailing: Icon(Icons.arrow_forward_ios, color: AppColors.textPrimary),
        title: Text(
          listTitle,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
        onTap: () {
          HapticFeedback.heavyImpact();
          // your action
          onTap();
        },
      ),
    );
  }
}
