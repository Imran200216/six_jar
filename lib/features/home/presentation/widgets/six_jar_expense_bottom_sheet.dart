import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:six_jar/commons/Widgets/six_jar_filled_icon_btn.dart';
import 'package:six_jar/commons/Widgets/six_jar_outlined_icon_btn.dart';
import 'package:six_jar/commons/Widgets/six_jar_text_field.dart';
import 'package:six_jar/core/constants/app_text_constants.dart';
import 'package:six_jar/core/theme/app_colors.dart';

void showSixJarAddExpenseBottomSheet({
  required BuildContext context,
  required TextEditingController amountController,
  required TextEditingController descriptionController,
  required VoidCallback onAddExpense,
  String title = "Necessities",
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.transparentColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (context) {
      return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Add Expense from
              Text(
                "${AppTextConstants.addExpenseBottomSheetTitle} $title",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 30.h),

              // Amount text field
              SixJarTextField(
                textFieldLabel: AppTextConstants.expenseAmount,
                keyboardType: TextInputType.number,
                controller: amountController,
                hint: "0.00",
                prefixIcon: Icons.attach_money,
              ),

              SizedBox(height: 12.h),

              // Expense Description Text field
              SixJarTextField(
                textFieldLabel: AppTextConstants.description,
                keyboardType: TextInputType.text,
                controller: descriptionController,
                hint: AppTextConstants.expenseDescripton,
                prefixIcon: Icons.description,
                maxLines: 4,
              ),

              SizedBox(height: 30.h),

              // Add Expense
              SixJarFilledIconBtn(
                width: double.infinity,
                height: 34.h,
                onPressed: onAddExpense,
                icon: Icons.add_outlined,
                label: AppTextConstants.addExpense,
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
