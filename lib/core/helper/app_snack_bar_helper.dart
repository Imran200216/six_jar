import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:six_jar/core/theme/app_colors.dart';

class AppSnackBarHelper {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    required bool isSuccess,
  }) {
    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: isSuccess
          ? AppColors.snackBarSuccessBgColor
          : AppColors.snackBarFailureBgColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4.r),
      ),
      margin:  EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      duration: const Duration(seconds: 4),
      content: Row(
        children: [
          Icon(
            isSuccess ? Icons.check_circle : Icons.error,
            color: isSuccess
                ? AppColors.snackBarSuccessTextColor
                : AppColors.snackBarFailureTextColor,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontFamily: "Poppins",
                color: isSuccess
                    ? AppColors.snackBarSuccessTextColor
                    : AppColors.snackBarFailureTextColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              size: 20.w,
              color: AppColors.snackBarCloseIconColor,
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
