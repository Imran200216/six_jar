import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:six_jar/core/theme/app_colors.dart';

class SixJarTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hint;
  final TextInputType keyboardType;
  final bool isPassword;
  final int maxLines;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final bool enabled;
  final IconData prefixIcon;
  final List<String>? autoFillHints;
  final String? textFieldLabel;

  const SixJarTextField({
    super.key,
    required this.controller,
    this.hint,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.maxLines = 1,
    this.validator,
    this.onChanged,
    this.enabled = true,
    required this.prefixIcon,
    this.autoFillHints,
    this.textFieldLabel,
  });

  @override
  State<SixJarTextField> createState() => _SixJarTextFieldState();
}

class _SixJarTextFieldState extends State<SixJarTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 6.h,
      children: [
        if (widget.textFieldLabel != null) ...[
          Text(
            widget.textFieldLabel!,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w500,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 6.h),
        ],

        // text field
        TextFormField(
          autofillHints: widget.autoFillHints,
          style: TextStyle(
            fontFamily: "Poppins",
            fontSize: 13.sp,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
          cursorColor: AppColors.primary,
          controller: widget.controller,
          keyboardType: widget.keyboardType,
          obscureText: widget.isPassword ? _obscureText : false,
          maxLines: widget.maxLines,
          enabled: widget.enabled,
          validator: widget.validator,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            errorStyle: TextStyle(
              fontFamily: "Poppins",
              fontSize: 11.sp,
              color: AppColors.textFieldErrorBorderColor,
              fontWeight: FontWeight.w500,
            ),
            hintText: widget.hint,
            hintStyle: TextStyle(
              fontFamily: "Poppins",
              fontSize: 13.sp,
              color: AppColors.textFieldHintColor,
              fontWeight: FontWeight.w500,
            ),
            prefixIcon: Icon(widget.prefixIcon, color: AppColors.textSecondary),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: _toggleVisibility,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.r),
              borderSide: BorderSide(color: AppColors.primary, width: 1.2.w),
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
      ],
    );
  }
}
