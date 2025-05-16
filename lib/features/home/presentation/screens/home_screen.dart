import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:six_jar/commons/bloc/connectivity_bloc.dart';
import 'package:six_jar/core/constants/app_text_constants.dart';
import 'package:six_jar/core/helper/app_snack_bar_helper.dart';
import 'package:six_jar/core/theme/app_colors.dart';
import 'package:six_jar/features/home/presentation/widgets/six_jar_chart_diagram.dart';
import 'package:six_jar/features/home/presentation/widgets/six_jar_container.dart';
import 'package:six_jar/features/home/presentation/widgets/six_jar_drawer.dart';
import 'package:six_jar/features/home/presentation/widgets/six_jar_expense_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Controllers
  final TextEditingController necessitiesExpenseAmountController =
      TextEditingController();

  final TextEditingController necessitiesExpenseDescriptionController =
      TextEditingController();

  final TextEditingController playExpenseAmountController =
      TextEditingController();

  final TextEditingController playExpenseDescriptionController =
      TextEditingController();

  final TextEditingController educationExpenseAmountController =
      TextEditingController();

  final TextEditingController educationExpenseDescriptionController =
      TextEditingController();

  final TextEditingController savingsExpenseAmountController =
      TextEditingController();

  final TextEditingController savingsExpenseDescriptionController =
      TextEditingController();

  final TextEditingController giveExpenseAmountController =
      TextEditingController();

  final TextEditingController giveExpenseDescriptionController =
      TextEditingController();

  final TextEditingController financialFreedomExpenseAmountController =
      TextEditingController();

  final TextEditingController financialFreedomExpenseDescriptionController =
      TextEditingController();

  @override
  void dispose() {
    // Necessities
    necessitiesExpenseAmountController.dispose();
    necessitiesExpenseDescriptionController.dispose();

    // Play
    playExpenseAmountController.dispose();
    playExpenseDescriptionController.dispose();

    // Education
    educationExpenseAmountController.dispose();
    educationExpenseDescriptionController.dispose();

    // Savings
    savingsExpenseAmountController.dispose();
    savingsExpenseDescriptionController.dispose();

    // Give
    giveExpenseAmountController.dispose();
    giveExpenseDescriptionController.dispose();

    // Financial Freedom
    financialFreedomExpenseAmountController.dispose();
    financialFreedomExpenseDescriptionController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Internect Connectivity Bloc
        BlocProvider(create: (context) => ConnectivityBloc()),
      ],
      child: MultiBlocListener(
        listeners: [
          // Internet Connectivity Listener
          BlocListener<ConnectivityBloc, ConnectivityState>(
            listener: (context, state) {
              if (state is ConnectivitySuccess) {
                // success snackbar
                AppSnackBarHelper.showSnackBar(
                  context: context,
                  message: AppTextConstants.internetSuccessText,
                  isSuccess: true,
                  customIcon: Icons.signal_cellular_4_bar_outlined,
                );
              } else if (state is ConnectivityFailure) {
                // failure snackbar
                AppSnackBarHelper.showSnackBar(
                  context: context,
                  message: AppTextConstants.internetFailureText,
                  isSuccess: false,
                  customIcon: Icons.mobiledata_off_sharp,
                );
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: AppColors.background,
          drawer: SixJarDrawer(
            userName: 'John Doe',
            userEmail: 'john.doe@example.com',
            userImageUrl: 'https://via.placeholder.com/150',
            onHomeTap: () {
              // Handle home navigation logic
            },
            onSettingsTap: () {
              // Handle settings navigation
            },
            onLogoutTap: () {
              // Handle logout logic
            },
          ),

          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              // App Bar
              SliverAppBar(
                floating: false,
                pinned: true,
                expandedHeight: 300.h,
                backgroundColor: AppColors.primary,

                leading: Builder(
                  builder: (context) {
                    return IconButton(
                      icon: Icon(Icons.menu, color: AppColors.background),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    );
                  },
                ),

                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    AppTextConstants.appNameText,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: AppColors.background,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  centerTitle: true,
                  background: Container(color: AppColors.primary),
                ),
              ),

              // Content Section
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      spacing: 16.h,
                      children: [
                        // Jar 1: Necessities
                        SixJarContainer(
                          jarName: AppTextConstants.jarNecessitiesName,
                          jarDescription:
                              AppTextConstants.jarNecessitiesDescription,
                          amount: "Rs. 400",
                          color: AppColors.necessitiesColor,
                          icon: Icons.shopping_cart,
                          jarPercent: AppTextConstants.jarNecessitiesPercent,
                          chartValues: [20, 30, 45, 60, 70, 90],
                          balanceAmount: "Rs. 10,000",
                          onAddExpense: () {
                            // Bottom Modal Sheet
                            showSixJarAddExpenseBottomSheet(
                              context: context,
                              title: AppTextConstants.jarNecessitiesName,
                              amountController:
                                  necessitiesExpenseAmountController,
                              descriptionController:
                                  necessitiesExpenseDescriptionController,
                              onAddExpense: () {},
                            );
                          },
                        ),

                        // Jar 2: Play
                        SixJarContainer(
                          jarName: AppTextConstants.jarPlayName,
                          jarDescription: AppTextConstants.jarPlayDescription,
                          amount: "Rs. 100",
                          color: AppColors.playColor,
                          icon: Icons.sports_esports,
                          jarPercent: AppTextConstants.jarPlayPercent,
                          chartValues: [20, 30, 45, 60, 70, 90],
                          balanceAmount: "Rs. 10,000",
                          onAddExpense: () {
                            // Bottom Modal Sheet
                            showSixJarAddExpenseBottomSheet(
                              context: context,
                              title: AppTextConstants.jarPlayName,
                              amountController: playExpenseAmountController,
                              descriptionController:
                                  playExpenseDescriptionController,
                              onAddExpense: () {},
                            );
                          },
                        ),

                        // Jar 3: Education
                        SixJarContainer(
                          jarName: AppTextConstants.jarEducationName,
                          jarDescription:
                              AppTextConstants.jarEducationDescription,
                          amount: "Rs. 100",
                          color: AppColors.educationColor,
                          icon: Icons.school,
                          jarPercent: AppTextConstants.jarEducationPercent,
                          chartValues: [20, 30, 45, 60, 70, 90],
                          balanceAmount: "Rs. 10,000",
                          onAddExpense: () {
                            // Bottom Modal Sheet
                            showSixJarAddExpenseBottomSheet(
                              context: context,
                              title: AppTextConstants.jarEducationName,
                              amountController:
                                  educationExpenseAmountController,
                              descriptionController:
                                  educationExpenseDescriptionController,
                              onAddExpense: () {},
                            );
                          },
                        ),

                        // Jar 4: Savings
                        SixJarContainer(
                          jarName: AppTextConstants.jarSavingsName,
                          jarDescription:
                              AppTextConstants.jarSavingsDescription,
                          amount: "Rs. 100",
                          color: AppColors.savingsColor,
                          icon: Icons.savings,
                          jarPercent: AppTextConstants.jarSavingsPercent,
                          chartValues: [20, 30, 45, 60, 70, 90],
                          balanceAmount: "Rs. 10,000",
                          onAddExpense: () {
                            // Bottom Modal Sheet
                            showSixJarAddExpenseBottomSheet(
                              context: context,
                              title: AppTextConstants.jarSavingsName,
                              amountController: savingsExpenseAmountController,
                              descriptionController:
                                  savingsExpenseDescriptionController,
                              onAddExpense: () {},
                            );
                          },
                        ),

                        // Jar 5: Give
                        SixJarContainer(
                          jarName: AppTextConstants.jarGiveName,
                          jarDescription: AppTextConstants.jarGiveDescription,
                          amount: "Rs. 100",
                          color: AppColors.giveColor,
                          icon: Icons.volunteer_activism,
                          jarPercent: AppTextConstants.jarGivePercent,
                          chartValues: [20, 30, 45, 60, 70, 90],
                          balanceAmount: "Rs. 10,000",
                          onAddExpense: () {
                            // Bottom Modal Sheet
                            showSixJarAddExpenseBottomSheet(
                              context: context,
                              title: AppTextConstants.jarGiveName,
                              amountController: giveExpenseAmountController,
                              descriptionController:
                                  giveExpenseDescriptionController,
                              onAddExpense: () {},
                            );
                          },
                        ),

                        // Jar 6: Financial Freedom
                        SixJarContainer(
                          jarName: AppTextConstants.jarFinancialFreedomName,
                          jarDescription:
                              AppTextConstants.jarFinancialFreedomDescription,
                          amount: "Rs. 100",
                          color: AppColors.financialFreedomColor,
                          icon: Icons.attach_money,
                          jarPercent:
                              AppTextConstants.jarFinancialFreedomPercent,
                          chartValues: [20, 30, 45, 60, 70, 90],
                          balanceAmount: "Rs. 10,000",
                          onAddExpense: () {
                            // Bottom Modal Sheet
                            showSixJarAddExpenseBottomSheet(
                              context: context,
                              title: AppTextConstants.jarFinancialFreedomName,
                              amountController:
                                  financialFreedomExpenseAmountController,
                              descriptionController:
                                  financialFreedomExpenseDescriptionController,
                              onAddExpense: () {},
                            );
                          },
                        ),

                        // Jar Distribution
                        SixJarChartDiagram(),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
