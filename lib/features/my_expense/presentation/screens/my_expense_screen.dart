import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:six_jar/commons/Widgets/six_jar_app_bar.dart';
import 'package:six_jar/core/constants/app_text_constants.dart';
import 'package:six_jar/core/helper/app_snack_bar_helper.dart';
import 'package:six_jar/core/theme/app_colors.dart';
import 'package:six_jar/features/my_expense/presentation/blocs/jar_selection_bloc/jar_selection_bloc.dart';
import 'package:six_jar/features/my_expense/presentation/widgets/six_jar_expense_list_tile.dart';
import 'package:six_jar/features/my_expense/presentation/widgets/six_jar_filter_bottom_modal_sheet.dart';


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
                  // Filter Bottom Modal Sheet
                  showSixJarFilterBottomModalSheet(
                    context: context,
                    startDateRangeController: startDateRangeController,
                    endDateRangeController: endDateRangeController,
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
