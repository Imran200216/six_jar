import 'package:flutter/material.dart';
import 'package:six_jar/core/theme/app_colors.dart'; 

class AppSnackBarHelper {
  static void showSnackBar({
    required BuildContext context,
    required String message,
    required bool isSuccess,
  }) {
    final snackBar = SnackBar(
      content: Row(
        children: [
          Icon(
            isSuccess ? Icons.check_circle : Icons.error,
            color: isSuccess
                ? AppColors.snackBarSuccessTextColor
                : AppColors.snackBarFailureTextColor,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                fontFamily: "Poppins",
                color: isSuccess
                    ? AppColors.snackBarSuccessTextColor
                    : AppColors.snackBarFailureTextColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: isSuccess
          ? AppColors.snackBarSuccessBgColor
          : AppColors.snackBarFailureBgColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      action: SnackBarAction(
        label: 'Close',
        textColor: AppColors.snackBarCloseIconColor,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
