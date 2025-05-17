import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SixJarSelectionChip extends StatelessWidget {
  final String chipTitle;
  final Color chipTitleActiveColor;
  final Color chipTitleInActiveColor;
  final IconData chipIconNotSelectedIcon;
  final IconData chipIconSelectedIcon;
  final Color iconActiveColor;
  final Color iconInActiveColor;
  final Color chipActiveBgColor;
  final Color chipInActiveBgColor;
  final bool isSelected;
  final VoidCallback? onTap;

  const SixJarSelectionChip({
    super.key,
    required this.chipTitle,
    required this.chipTitleActiveColor,
    required this.chipTitleInActiveColor,
    required this.chipIconNotSelectedIcon,
    required this.chipIconSelectedIcon,
    required this.iconActiveColor,
    required this.iconInActiveColor,
    required this.chipActiveBgColor,
    required this.chipInActiveBgColor,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Text(
          chipTitle,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            color: isSelected ? chipTitleActiveColor : chipTitleInActiveColor,
            fontWeight: FontWeight.w600,
            fontSize: 12.sp,
          ),
        ),
      ),
      selected: isSelected,
      avatar: Icon(
        isSelected ? chipIconSelectedIcon : chipIconNotSelectedIcon,
        size: 22,
        color: isSelected ? iconActiveColor : iconInActiveColor,
      ),
      backgroundColor: chipInActiveBgColor,
      selectedColor: chipActiveBgColor,
      showCheckmark: false,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
      onSelected: (_) => onTap?.call(),
    );
  }
}
