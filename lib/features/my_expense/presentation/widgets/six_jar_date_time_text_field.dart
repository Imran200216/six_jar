import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:six_jar/core/theme/app_colors.dart';

class SixJarDatePickerTextField extends StatefulWidget {
  final String? hint;
  final String? label;
  final DateTime? initialDate;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final ValueChanged<DateTime>? onDateSelected;
  final TextEditingController controller;
  final bool enabled;

  const SixJarDatePickerTextField({
    super.key,
    this.hint,
    this.label,
    this.initialDate,
    this.firstDate,
    this.lastDate,
    required this.controller,
    this.onDateSelected,
    this.enabled = true,
  });

  @override
  State<SixJarDatePickerTextField> createState() =>
      _SixJarDatePickerTextFieldState();
}

class _SixJarDatePickerTextFieldState extends State<SixJarDatePickerTextField> {
  Future<void> _selectDate(BuildContext context) async {
    if (!widget.enabled) return;

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: widget.initialDate ?? DateTime.now(),
      firstDate: widget.firstDate ?? DateTime(1900),
      lastDate: widget.lastDate ?? DateTime(2100),
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.light(
            primary: AppColors.primary,
            onPrimary: Colors.white,
            onSurface: AppColors.textPrimary,
          ),
        ),
        child: child!,
      ),
    );

    if (picked != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      widget.controller.text = formattedDate;
      widget.onDateSelected?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 5.h),
        ],
        GestureDetector(
          onTap: () => _selectDate(context),
          child: AbsorbPointer(
            child: TextFormField(
              controller: widget.controller,
              style: TextStyle(
                fontFamily: "Poppins",
                fontSize: 13.sp,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                hintText: widget.hint ?? 'Select date',
                hintStyle: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 13.sp,
                  color: AppColors.textFieldHintColor,
                  fontWeight: FontWeight.w500,
                ),
                suffixIcon: Icon(
                  Icons.calendar_month,
                  color: AppColors.textSecondary,
                  size: 20.sp,
                ),
                enabled: widget.enabled,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: AppColors.primary,
                    width: 1.2.w,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: AppColors.textFieldErrorBorderColor,
                    width: 1.2.w,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide(
                    color: AppColors.textFieldErrorBorderColor,
                    width: 1.2.w,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 8.h,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
