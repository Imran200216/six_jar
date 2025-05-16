import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:six_jar/core/theme/app_colors.dart';

class SixJarSettingsListTile extends StatelessWidget {
  final String jarName;
  final String jarPercentage;
  final double percentage;
  final Color activeColor;
  final Color inactiveColor;
  final double barHeight;

  const SixJarSettingsListTile({
    super.key,
    required this.percentage,
    required this.activeColor,
    required this.inactiveColor,
    required this.barHeight,
    required this.jarName,
    required this.jarPercentage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Necessities
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Jar Name
            Text(
              jarName,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
              ),
            ),

            // Jar Percentage
            Text(
              jarPercentage,
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),

        SizedBox(
          height: barHeight,
          child: RotatedBox(
            quarterTurns: 1,
            child: BarChart(
              BarChartData(
                maxY: 100,
                alignment: BarChartAlignment.center,
                titlesData: FlTitlesData(show: false),
                gridData: FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: [
                  BarChartGroupData(
                    x: 0,
                    barRods: [
                      BarChartRodData(
                        toY: 100,
                        width: 20.w,
                        borderRadius: BorderRadius.circular(4),
                        rodStackItems: [
                          BarChartRodStackItem(0, percentage, activeColor),
                          BarChartRodStackItem(percentage, 100, inactiveColor),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
