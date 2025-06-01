import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:six_jar/commons/Widgets/six_jar_filled_icon_btn.dart';
import 'package:six_jar/commons/Widgets/six_jar_outlined_icon_btn.dart';
import 'package:six_jar/commons/Widgets/six_jar_text_field.dart';
import 'package:six_jar/core/constants/app_text_constants.dart';
import 'package:six_jar/core/theme/app_colors.dart';

void showSixJarAddIncomeBottomSheet({
  required BuildContext context,
  required VoidCallback onAddIncome,
  required TextEditingController incomeController,
}) {
  showBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            bottom: 30.h,
            top: 10.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drawer Header Line
              Container(
                height: 4.h,
                width: 40.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  color: AppColors.primary,
                ),
              ),

              SizedBox(height: 20.h),

              // Add Income from
              Text(
                AppTextConstants.addIncome,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 30.h),

              // Income Amount text field
              SixJarTextField(
                textFieldLabel: AppTextConstants.expenseAmount,
                keyboardType: TextInputType.number,
                controller: incomeController,
                hint: "0.00",
                prefixIcon: Icons.attach_money,
              ),

              SizedBox(height: 20.h),

              // Add Expense
              SixJarFilledIconBtn(
                width: double.infinity,
                height: 34.h,
                onPressed: onAddIncome,
                icon: Icons.add_outlined,
                label: AppTextConstants.addIncome,
              ),
              SizedBox(height: 12.h),

              // Cancel btn
              SixJarOutlinedIconBtn(
                width: double.infinity,
                borderColor: AppColors.textSecondary,
                height: 34.h,
                onPressed: () => GoRouter.of(context).pop(),
                iconData: Icons.cancel_outlined,
                label: AppTextConstants.cancelText,
              ),
            ],
          ),
        ),
      );
    },
  );
}
