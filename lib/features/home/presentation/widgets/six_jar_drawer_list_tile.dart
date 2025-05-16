import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:six_jar/core/helper/app_haptics_helper.dart';
import 'package:six_jar/core/theme/app_colors.dart';

class SixJarDrawerListTile extends StatelessWidget {
  final VoidCallback onTap;
  final String drawerTitle;
  final IconData drawerIcon;

  const SixJarDrawerListTile({
    super.key,
    required this.onTap,
    required this.drawerTitle,
    required this.drawerIcon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(drawerIcon),
      title: Text(drawerTitle),
      titleTextStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
        fontSize: 14.sp,
      ),
      onTap: () {
        AppHapticHelper.heavyImpact();

        onTap();
      },
    );
  }
}
