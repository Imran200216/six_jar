import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:six_jar/commons/Widgets/six_jar_filled_icon_btn.dart';
import 'package:six_jar/core/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:six_jar/core/constants/app_router_constants.dart';
import 'package:six_jar/core/constants/app_text_constants.dart';
import 'package:six_jar/core/helper/app_snack_bar_helper.dart';
import 'package:six_jar/core/theme/app_colors.dart';
import 'package:six_jar/features/home/presentation/blocs/sliver_scroll/sliver_scroll_bloc.dart';
import 'package:six_jar/features/home/presentation/widgets/six_jar_add_income_bottom_sheet.dart';
import 'package:six_jar/features/home/presentation/widgets/six_jar_chart_diagram.dart';
import 'package:six_jar/features/home/presentation/widgets/six_jar_container.dart';
import 'package:six_jar/features/home/presentation/widgets/six_jar_drawer.dart';
import 'package:six_jar/features/home/presentation/widgets/six_jar_expense_bottom_sheet.dart';
import 'package:six_jar/features/home/presentation/widgets/six_jar_logout_bottom_modal_sheet.dart';

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

  // Six Jar Add Income Bottom Sheet (Income Controller)
  final TextEditingController addIncomeController = TextEditingController();

  // Scroll controler
  final ScrollController _scrollController = ScrollController();
  late SliverScrollBloc _scrollBloc;

  @override
  void initState() {
    super.initState();

    // Sliver Scroll Bloc
    _scrollBloc = SliverScrollBloc();
    _scrollController.addListener(() {
      _scrollBloc.add(ScrollOffsetChanged(_scrollController.offset));
    });
  }

  @override
  void dispose() {
    _scrollBloc.close();
    _scrollController.dispose();

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

    // Six Jar Add Income Bottom Sheet (Income Controller)
    addIncomeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Internect Connectivity Bloc
        BlocProvider(create: (context) => ConnectivityBloc()),

        // Sliver Scroll Bloc
        BlocProvider.value(value: _scrollBloc),
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
            userName: 'Ijass',
            userEmail: 'Ijassmohammed@gmail.com',
            userImageUrl:
                'https://images.unsplash.com/photo-1503443207922-dff7d543fd0e?q=80&w=2427&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
            onMyExpenseTap: () {
              // Expense Screen
              GoRouter.of(context).pushNamed(AppRouteConstants.myExpense.name);
            },
            onAboutTap: () {
              // About Screen
              GoRouter.of(context).pushNamed(AppRouteConstants.about.name);
            },
            onSettingsTap: () {
              // Settings Screen
              GoRouter.of(context).pushNamed(AppRouteConstants.settting.name);
            },
            onLogoutTap: () {
              // Log out bottom modal sheet
              showSixJarLogoutBottomSheet(
                context: context,
                onConfirmLogout: () {
                  // Logout logic
                },
              );
            },
          ),

          body: BlocBuilder<SliverScrollBloc, SliverScrollState>(
            builder: (context, state) {
              final isCollapsed = state is ScrollCollapsedState;

              return CustomScrollView(
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                slivers: [
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
                      centerTitle: true,
                      title:
                          isCollapsed
                              ? Text(
                                AppTextConstants.appNameText,
                                style: Theme.of(
                                  context,
                                ).textTheme.headlineSmall?.copyWith(
                                  color: AppColors.background,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.sp,
                                ),
                              )
                              : null,

                      background: Container(
                        color: AppColors.primary,
                        child: Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 80.h,
                              bottom: 20.h,
                              right: 16.w,
                              left: 16.w,
                            ),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: AppColors.background,
                                borderRadius: BorderRadius.circular(10.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10,
                                    offset: Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    spacing: 10.w,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // six jar logo
                                      Icon(
                                        Icons.savings,
                                        size: 28.w,
                                        color: AppColors.primary,
                                      ),

                                      // Six Jar
                                      Text(
                                        AppTextConstants.appNameText,
                                        textAlign: TextAlign.start,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineLarge?.copyWith(
                                          color: AppColors.primary,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20.sp,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 6.h),

                                  Text(
                                    AppTextConstants.sixJarQuote,
                                    textAlign: TextAlign.start,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineLarge?.copyWith(
                                      color: AppColors.textSecondary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 13.sp,
                                    ),
                                  ),

                                  SizedBox(height: 12.h),

                                  // Title
                                  Text(
                                    AppTextConstants.totalBalance,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineLarge?.copyWith(
                                      color: AppColors.textSecondary,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                    ),
                                  ),

                                  SizedBox(height: 6.h),

                                  // Total Balance Amount
                                  Text(
                                    "Rs. 10,000 (INR)",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.headlineLarge?.copyWith(
                                      color: AppColors.textPrimary,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 20.sp,
                                    ),
                                  ),

                                  SizedBox(height: 12.h),

                                  // Add income
                                  SixJarFilledIconBtn(
                                    height: 36.h,
                                    width: double.infinity,
                                    onPressed: () {
                                      // show Add Income Bottom Sheet
                                      showSixJarAddIncomeBottomSheet(
                                        context: context,
                                        onAddIncome: () {},
                                        incomeController: addIncomeController,
                                      );
                                    },
                                    icon: Icons.add,
                                    label: "Add Income",
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
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
                              jarPercent:
                                  AppTextConstants.jarNecessitiesPercent,
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
                              jarDescription:
                                  AppTextConstants.jarPlayDescription,
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
                                  amountController:
                                      savingsExpenseAmountController,
                                  descriptionController:
                                      savingsExpenseDescriptionController,
                                  onAddExpense: () {},
                                );
                              },
                            ),

                            // Jar 5: Give
                            SixJarContainer(
                              jarName: AppTextConstants.jarGiveName,
                              jarDescription:
                                  AppTextConstants.jarGiveDescription,
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
                                  AppTextConstants
                                      .jarFinancialFreedomDescription,
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
                                  title:
                                      AppTextConstants.jarFinancialFreedomName,
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
              );
            },
          ),
        ),
      ),
    );
  }
}
