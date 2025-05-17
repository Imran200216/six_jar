import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:six_jar/core/theme/app_colors.dart';

class SixJarAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final bool showBackButton;
  final List<Widget>? actions;

  const SixJarAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.showBackButton = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      leading: showBackButton
          ? IconButton(
              onPressed: onBack ?? () => Navigator.of(context).pop(),
              icon: Icon(Icons.arrow_back, color: AppColors.background),
            )
          : null,
      title: Text(title),
      titleTextStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: AppColors.background,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
      centerTitle: true,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
