import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:six_jar/core/theme/app_colors.dart';
import 'package:six_jar/features/my_expense/presentation/blocs/range_slider_bloc/range_slider_bloc.dart';

class SixJarFilterSlider extends StatelessWidget {
  final double min;
  final double max;
  final int? divisions;

  const SixJarFilterSlider({
    super.key,
    required this.min,
    required this.max,
    this.divisions,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RangeSliderBloc, RangeSliderState>(
      builder: (context, state) {
        final currentValues = state.range;
        double sliderWidth = MediaQuery.of(context).size.width - 48;
        double startPercent = (currentValues.start - min) / (max - min);
        double endPercent = (currentValues.end - min) / (max - min);
        double startX = startPercent * sliderWidth;
        double endX = endPercent * sliderWidth;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.centerLeft,
              children: [
                // Range Slider
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: AppColors.primary,
                      inactiveTrackColor: AppColors.primaryLight,
                      thumbColor: AppColors.primary,
                      overlayColor: AppColors.primary.withOpacity(0.2),
                      activeTickMarkColor: AppColors.primary,
                      inactiveTickMarkColor: AppColors.primaryLight,
                      tickMarkShape: const RoundSliderTickMarkShape(
                        tickMarkRadius: 2,
                      ),
                    ),
                    child: RangeSlider(
                      values: currentValues,
                      min: min,
                      max: max,
                      divisions: divisions ?? 10,
                      onChanged: (values) {
                        context.read<RangeSliderBloc>().add(
                          UpdateRangeSliderEvent(values),
                        );
                      },
                    ),
                  ),
                ),
                // Start thumb label
                Positioned(
                  left: 24 + startX - 12,
                  top: 45,
                  child: Text(
                    currentValues.start.round().toString(),
                    style: TextStyle(color: AppColors.textPrimary),
                  ),
                ),
                // End thumb label
                Positioned(
                  left: 24 + endX - 12,
                  top: 45,
                  child: Text(
                    currentValues.end.round().toString(),
                    style: TextStyle(color: AppColors.textPrimary),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),

            //  Range Slider Values
            Text(
              'Selected Range: Rs. ${currentValues.start.round()} - Rs. ${currentValues.end.round()}',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w500,
                fontSize: 13.sp,
              ),
            ),
          ],
        );
      },
    );
  }
}
