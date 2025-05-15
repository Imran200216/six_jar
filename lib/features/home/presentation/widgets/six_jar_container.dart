import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:six_jar/core/theme/app_colors.dart';
import 'package:six_jar/features/home/presentation/widgets/six_jar_add_expense_filled_btn.dart';

class SixJarContainer extends StatelessWidget {
  final String jarName;
  final String amount;
  final Color color;
  final IconData icon;
  final String jarPercent;
  final String jarDescription;
  final List<double> chartValues;
  final String balanceAmount;
  final VoidCallback onAddExpense;

  const SixJarContainer({
    super.key,
    required this.jarName,
    required this.amount,
    required this.color,
    required this.icon,
    required this.jarPercent,
    required this.jarDescription,
    required this.chartValues,
    required this.balanceAmount,
    required this.onAddExpense,
  });

  @override
  Widget build(BuildContext context) {
    final List<FlSpot> chartSpots = List.generate(
      chartValues.length,
      (index) => FlSpot(index.toDouble(), chartValues[index]),
    );

    return Container(
      padding: EdgeInsets.all(16.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: color, width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon, color: color),
                  SizedBox(width: 6.w),
                  Text(
                    jarName,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
              Container(
                height: 30.h,
                width: 40.w,
                alignment: Alignment.center,
                child: Text(
                  jarPercent,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 6.h),

          /// Jar description
          Text(
            jarDescription,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
            ),
          ),

          SizedBox(height: 22.h),

          /// Line Chart
          SizedBox(
            height: 120.h,
            child: LineChart(
              LineChartData(
                minX: 0,
                maxX: (chartValues.length - 1).toDouble(),
                minY: 0,
                maxY: 100,
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: true,
                  verticalInterval: 1,
                  horizontalInterval: 20,
                  getDrawingHorizontalLine: (value) =>
                      FlLine(color: Colors.grey.shade300, strokeWidth: 1),
                  getDrawingVerticalLine: (value) =>
                      FlLine(color: Colors.grey.shade300, strokeWidth: 1),
                ),

                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 1,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: EdgeInsets.only(top: 6.h),
                          child: Text(
                            'D${value.toInt() + 1}',
                            style: Theme.of(context).textTheme.headlineLarge
                                ?.copyWith(
                                  color: AppColors.textSecondary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 10.sp,
                                ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 20,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}',
                          style: Theme.of(context).textTheme.headlineLarge
                              ?.copyWith(
                                color: AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                                fontSize: 10.sp,
                              ),
                        );
                      },
                      reservedSize: 28,
                    ),
                  ),
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),

                borderData: FlBorderData(show: false),

                lineBarsData: [
                  LineChartBarData(
                    spots: chartSpots,
                    isCurved: true,
                    gradient: LinearGradient(
                      colors: [color, color.withOpacity(0.4)],
                    ),
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [color.withOpacity(0.3), Colors.transparent],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 22.h),

          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Balance Text
              Text(
                "Balance",
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),

              /// Balance Amount Text
              Text(
                balanceAmount,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),

          SizedBox(height: 22.h),

          // Add Expense Btn
          SixJarAddExpenseFilledBtn(
            width: double.infinity,
            onPressed: () {
              onAddExpense();
            },
            backgroundColor: color,
            label: "Add Expense",
            contentColor: AppColors.background,
            iconData: Icons.add,
          ),
        ],
      ),
    );
  }
}
