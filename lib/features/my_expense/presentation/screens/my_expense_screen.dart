import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:six_jar/commons/Widgets/six_jar_app_bar.dart';
import 'package:six_jar/commons/Widgets/six_jar_filled_icon_btn.dart';
import 'package:six_jar/commons/Widgets/six_jar_text_btn_field.dart';
import 'package:six_jar/core/constants/app_text_constants.dart';
import 'package:six_jar/core/helper/app_snack_bar_helper.dart';
import 'package:six_jar/core/theme/app_colors.dart';
import 'package:six_jar/features/my_expense/presentation/blocs/jar_selection_bloc/jar_selection_bloc.dart';
import 'package:six_jar/features/my_expense/presentation/widgets/six_jar_date_time_text_field.dart';
import 'package:six_jar/features/my_expense/presentation/widgets/six_jar_expense_list_tile.dart';
import 'package:six_jar/features/my_expense/presentation/widgets/six_jar_filter_slider.dart';
import 'package:six_jar/features/my_expense/presentation/widgets/six_jar_selection_chip.dart';

class MyExpenseScreen extends StatefulWidget {
  const MyExpenseScreen({super.key});

  @override
  State<MyExpenseScreen> createState() => _MyExpenseScreenState();
}

class _MyExpenseScreenState extends State<MyExpenseScreen> {
  // Controllerrs
  final TextEditingController startDateRangeController =
      TextEditingController();
  final TextEditingController endDateRangeController = TextEditingController();

  @override
  void dispose() {
    startDateRangeController.clear();
    endDateRangeController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Jar Selection Chip Bloc
        BlocProvider(create: (context) => JarSelectionBloc()),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<JarSelectionBloc, JarSelectionState>(
            listener: (context, state) {
              if (state.selectedJar.isNotEmpty) {
                // Success Added snackbar
                AppSnackBarHelper.showSnackBar(
                  context: context,
                  message: "${state.selectedJar} is Added To filter category",
                  isSuccess: true,
                );
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: SixJarAppBar(
            title: AppTextConstants.myExpense,
            showBackButton: true,
            onBack: () {
              // Back
              GoRouter.of(context).pop();
            },
            actions: [
              // Filter icon
              IconButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: AppColors.transparentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16.r),
                      ),
                    ),
                    builder: (context) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.background,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(16.r),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 30.h,
                          ),
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Filter Search Text
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Filter Search Text
                                    Text(
                                      AppTextConstants.filterSearch,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge
                                          ?.copyWith(
                                            color: AppColors.textPrimary,
                                            fontSize: 16.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),

                                    // close btn
                                    IconButton(
                                      onPressed: () {
                                        // Close bottom sheet
                                        GoRouter.of(context).pop();
                                      },
                                      icon: Icon(
                                        Icons.close,
                                        color: AppColors.snackBarCloseIconColor,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 16.h),

                                // Filter Description Text
                                Text(
                                  AppTextConstants.filterSearchDescription,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                        color: AppColors.textSecondary,
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),

                                SizedBox(height: 16.h),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //  Data range text
                                    Text(
                                      AppTextConstants.dateRange,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge
                                          ?.copyWith(
                                            color: AppColors.textPrimary,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),

                                    // clear all text btn
                                    SixJarTextBtn(
                                      text: AppTextConstants.clearAll,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                      onPressed: () {},
                                    ),
                                  ],
                                ),

                                SizedBox(height: 12.h),

                                Row(
                                  spacing: 10.w,
                                  children: [
                                    // Start DateRange Text Field
                                    Expanded(
                                      child: SixJarDatePickerTextField(
                                        label: AppTextConstants.from,
                                        controller: startDateRangeController,
                                      ),
                                    ),

                                    // End DateRangeController
                                    Expanded(
                                      child: SixJarDatePickerTextField(
                                        label: AppTextConstants.to,
                                        controller: endDateRangeController,
                                      ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 16.h),

                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Select Category text
                                    Text(
                                      AppTextConstants.selectCategory,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge
                                          ?.copyWith(
                                            color: AppColors.textPrimary,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),

                                    // clear all text btn
                                    BlocBuilder<
                                      JarSelectionBloc,
                                      JarSelectionState
                                    >(
                                      builder: (context, state) {
                                        // chip selectio bloc
                                        final bloc = context
                                            .read<JarSelectionBloc>();

                                        return SixJarTextBtn(
                                          text: AppTextConstants.clearAll,
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w600,
                                          onPressed: () {
                                            bloc.add(ClearJarSelectionEvent());
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),

                                SizedBox(height: 12.h),

                                // Jar Categroy Chips
                                BlocBuilder<
                                  JarSelectionBloc,
                                  JarSelectionState
                                >(
                                  builder: (context, state) {
                                    // chip selectio bloc
                                    final bloc = context
                                        .read<JarSelectionBloc>();

                                    return Wrap(
                                      spacing: 8.h,
                                      runSpacing: 8.w,
                                      runAlignment: WrapAlignment.start,
                                      children: [
                                        // Jar 1 Necessities chip
                                        SixJarSelectionChip(
                                          chipTitle: AppTextConstants
                                              .jarNecessitiesName,
                                          chipTitleActiveColor:
                                              AppColors.background,
                                          chipTitleInActiveColor:
                                              AppColors.necessitiesColor,
                                          chipIconNotSelectedIcon:
                                              Icons.shopping_cart,
                                          chipIconSelectedIcon:
                                              Icons.shopping_cart,
                                          iconActiveColor: AppColors.background,
                                          iconInActiveColor:
                                              AppColors.necessitiesColor,
                                          chipActiveBgColor:
                                              AppColors.necessitiesColor,
                                          chipInActiveBgColor: AppColors
                                              .necessitiesColor
                                              .withOpacity(0.3),
                                          isSelected:
                                              state.selectedJar ==
                                              AppTextConstants
                                                  .jarNecessitiesName,
                                          onTap: () {
                                            bloc.add(
                                              SelectJarEvent(
                                                AppTextConstants
                                                    .jarNecessitiesName,
                                              ),
                                            );
                                          },
                                        ),

                                        // jar 2 Play chip
                                        SixJarSelectionChip(
                                          chipTitle:
                                              AppTextConstants.jarPlayName,
                                          chipTitleActiveColor:
                                              AppColors.background,
                                          chipTitleInActiveColor:
                                              AppColors.playColor,
                                          chipIconNotSelectedIcon:
                                              Icons.sports_esports,
                                          chipIconSelectedIcon:
                                              Icons.sports_esports,
                                          iconActiveColor: AppColors.background,
                                          iconInActiveColor:
                                              AppColors.playColor,
                                          chipActiveBgColor:
                                              AppColors.playColor,
                                          chipInActiveBgColor: AppColors
                                              .playColor
                                              .withOpacity(0.3),
                                          isSelected:
                                              state.selectedJar ==
                                              AppTextConstants.jarPlayName,
                                          onTap: () {
                                            bloc.add(
                                              SelectJarEvent(
                                                AppTextConstants.jarPlayName,
                                              ),
                                            );
                                          },
                                        ),

                                        // Jar 3 Education chip
                                        SixJarSelectionChip(
                                          chipTitle:
                                              AppTextConstants.jarEducationName,
                                          chipTitleActiveColor:
                                              AppColors.background,
                                          chipTitleInActiveColor:
                                              AppColors.educationColor,
                                          chipIconNotSelectedIcon: Icons.school,
                                          chipIconSelectedIcon: Icons.school,
                                          iconActiveColor: AppColors.background,
                                          iconInActiveColor:
                                              AppColors.educationColor,
                                          chipActiveBgColor:
                                              AppColors.educationColor,
                                          chipInActiveBgColor: AppColors
                                              .educationColor
                                              .withOpacity(0.3),
                                          isSelected:
                                              state.selectedJar ==
                                              AppTextConstants.jarEducationName,
                                          onTap: () {
                                            bloc.add(
                                              SelectJarEvent(
                                                AppTextConstants
                                                    .jarEducationName,
                                              ),
                                            );
                                          },
                                        ),

                                        // Jar 4 savings chip
                                        SixJarSelectionChip(
                                          chipTitle:
                                              AppTextConstants.jarSavingsName,
                                          chipTitleActiveColor:
                                              AppColors.background,
                                          chipTitleInActiveColor:
                                              AppColors.savingsColor,
                                          chipIconNotSelectedIcon:
                                              Icons.savings,
                                          chipIconSelectedIcon: Icons.savings,
                                          iconActiveColor: AppColors.background,
                                          iconInActiveColor:
                                              AppColors.savingsColor,
                                          chipActiveBgColor:
                                              AppColors.savingsColor,
                                          chipInActiveBgColor: AppColors
                                              .savingsColor
                                              .withOpacity(0.3),
                                          isSelected:
                                              state.selectedJar ==
                                              AppTextConstants.jarSavingsName,
                                          onTap: () {
                                            bloc.add(
                                              SelectJarEvent(
                                                AppTextConstants.jarSavingsName,
                                              ),
                                            );
                                          },
                                        ),

                                        // jar 5 Give chip
                                        SixJarSelectionChip(
                                          chipTitle:
                                              AppTextConstants.jarGiveName,
                                          chipTitleActiveColor:
                                              AppColors.background,
                                          chipTitleInActiveColor:
                                              AppColors.giveColor,
                                          chipIconNotSelectedIcon:
                                              Icons.volunteer_activism,
                                          chipIconSelectedIcon:
                                              Icons.volunteer_activism,
                                          iconActiveColor: AppColors.background,
                                          iconInActiveColor:
                                              AppColors.giveColor,
                                          chipActiveBgColor:
                                              AppColors.giveColor,
                                          chipInActiveBgColor: AppColors
                                              .giveColor
                                              .withOpacity(0.3),
                                          isSelected:
                                              state.selectedJar ==
                                              AppTextConstants.jarGiveName,
                                          onTap: () {
                                            bloc.add(
                                              SelectJarEvent(
                                                AppTextConstants.jarGiveName,
                                              ),
                                            );
                                          },
                                        ),

                                        // Jar 6 Finanical Freedom chip
                                        SixJarSelectionChip(
                                          chipTitle: AppTextConstants
                                              .jarFinancialFreedomName,
                                          chipTitleActiveColor:
                                              AppColors.background,
                                          chipTitleInActiveColor:
                                              AppColors.financialFreedomColor,
                                          chipIconNotSelectedIcon:
                                              Icons.attach_money,
                                          chipIconSelectedIcon:
                                              Icons.attach_money,
                                          iconActiveColor: AppColors.background,
                                          iconInActiveColor:
                                              AppColors.financialFreedomColor,
                                          chipActiveBgColor:
                                              AppColors.financialFreedomColor,
                                          chipInActiveBgColor: AppColors
                                              .financialFreedomColor
                                              .withOpacity(0.3),
                                          isSelected:
                                              state.selectedJar ==
                                              AppTextConstants
                                                  .jarFinancialFreedomName,
                                          onTap: () {
                                            bloc.add(
                                              SelectJarEvent(
                                                AppTextConstants
                                                    .jarFinancialFreedomName,
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                ),

                                SizedBox(height: 16.h),

                                // Search Amount
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Search Amount Text
                                    Text(
                                      AppTextConstants.searchAmount,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge
                                          ?.copyWith(
                                            color: AppColors.textPrimary,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),

                                    // Selected Currency by the user
                                    Text(
                                      "INR",
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge
                                          ?.copyWith(
                                            color: AppColors.textSecondary,
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ],
                                ),

                                SizedBox(height: 12.h),

                                // Range Slider
                                const SixJarFilterSlider(
                                  min: 0,
                                  max: 200000,
                                  divisions: 10,
                                ),

                                SizedBox(height: 20.h),

                                // Apply Filters Bnt
                                SixJarFilledIconBtn(
                                  width: double.infinity,
                                  height: 38.h,
                                  onPressed: () {},
                                  icon: Icons.tune,
                                  label: "Apply Filters",
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
                icon: Icon(Icons.filter_list, color: AppColors.background),
              ),
            ],
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return SixJarExpenseListTile(
                      expenseDescription: "Party with Friends",
                      expenseCategorySelected: "Play",
                      dateOfExpense: "11/12/2025",
                      timeOfExpense: "4.00 pm",
                    );
                  },
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 8.h);
                  },
                  itemCount: 30,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
