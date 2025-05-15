import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:six_jar/core/theme/app_colors.dart';

class CurrencySelectScreen extends StatelessWidget {
  const CurrencySelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
        ),
      ),
    );
  }
}
