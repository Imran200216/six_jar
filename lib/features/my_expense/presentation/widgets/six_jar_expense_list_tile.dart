import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:six_jar/core/theme/app_colors.dart';

class SixJarExpenseListTile extends StatelessWidget {
  final String expenseDescription;
  final String expenseCategorySelected;
  final String dateOfExpense;
  final String timeOfExpense;

  const SixJarExpenseListTile({
    super.key,
    required this.expenseDescription,
    required this.expenseCategorySelected,
    required this.dateOfExpense,
    required this.timeOfExpense,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.background,
      shadowColor: AppColors.transparentColor,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
        side: BorderSide(color: AppColors.btnBorderColor),
      ),
      margin: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: ListTile(
          leading: Icon(Icons.wallet_rounded, color: AppColors.primary),
          title: Text(expenseDescription),
          titleTextStyle: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
          subtitle: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: 'Category: ',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: AppColors.textSecondary,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),
                TextSpan(
                  text: expenseCategorySelected,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: AppColors.textPrimary,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          trailing: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dateOfExpense,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                timeOfExpense,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
