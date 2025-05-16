import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:six_jar/core/constants/app_text_constants.dart';
import 'package:six_jar/core/theme/app_colors.dart';
import 'package:six_jar/features/home/presentation/widgets/six_jar_settings_list_tile.dart';

class SixJarChartDiagram extends StatelessWidget {
  const SixJarChartDiagram({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.h),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.primary, width: 1.5),
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Jar Distribution Text
          Text(
            AppTextConstants.jarDistributionText,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),

          SizedBox(height: 8.h),

          // Jar Distribution Description Text
          Text(
            AppTextConstants.jarDistributionDescriptionText,
            textAlign: TextAlign.start,
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
              fontSize: 13.sp,
            ),
          ),

          SizedBox(height: 14.h),

          Column(
            spacing: 5.h,
            children: [
              // necessities list tile
              SixJarSettingsListTile(
                percentage: 55,
                activeColor: AppColors.primary,
                inactiveColor: AppColors.primaryLight,
                barHeight: 40.h,
                jarName: AppTextConstants.jarNecessitiesName,
                jarPercentage: "55%",
              ),

              // Play list tile
              SixJarSettingsListTile(
                percentage: 10,
                activeColor: AppColors.primary,
                inactiveColor: AppColors.primaryLight,
                barHeight: 40.h,
                jarName: AppTextConstants.jarPlayName,
                jarPercentage: "10%",
              ),

              // Education list tile
              SixJarSettingsListTile(
                percentage: 10,
                activeColor: AppColors.primary,
                inactiveColor: AppColors.primaryLight,
                barHeight: 40.h,
                jarName: AppTextConstants.jarEducationName,
                jarPercentage: "10%",
              ),

              // Long Term list tile
              SixJarSettingsListTile(
                percentage: 10,
                activeColor: AppColors.primary,
                inactiveColor: AppColors.primaryLight,
                barHeight: 40.h,
                jarName: AppTextConstants.jarSavingsName,
                jarPercentage: "10%",
              ),

              // Give List Tile
              SixJarSettingsListTile(
                percentage: 5,
                activeColor: AppColors.primary,
                inactiveColor: AppColors.primaryLight,
                barHeight: 40.h,
                jarName: AppTextConstants.jarGiveName,
                jarPercentage: "5%",
              ),

              // Financial Freedom List Tile
              SixJarSettingsListTile(
                percentage: 10,
                activeColor: AppColors.primary,
                inactiveColor: AppColors.primaryLight,
                barHeight: 40.h,
                jarName: AppTextConstants.jarFinancialFreedomName,
                jarPercentage: "10%",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
