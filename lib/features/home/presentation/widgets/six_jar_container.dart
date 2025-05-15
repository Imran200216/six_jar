import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SixJarContainer extends StatelessWidget {
  final String jarName;
  final String amount;
  final Color color;
  final IconData icon;

  const SixJarContainer({
    super.key,
    required this.jarName,
    required this.amount,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            child: Icon(icon, color: color),
          ),
          SizedBox(width: 16.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                jarName,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                  color: color,
                ),
              ),
              Text(
                amount,
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
