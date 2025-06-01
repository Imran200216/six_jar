import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:six_jar/commons/Widgets/six_jar_filled_icon_btn.dart';
import 'package:six_jar/core/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:six_jar/core/constants/app_assets_constants.dart';
import 'package:six_jar/core/constants/app_db_constants.dart';
import 'package:six_jar/core/constants/app_router_constants.dart';
import 'package:six_jar/core/constants/app_text_constants.dart';
import 'package:six_jar/core/helper/app_logger_helper.dart';
import 'package:six_jar/core/helper/app_snack_bar_helper.dart';
import 'package:six_jar/core/theme/app_colors.dart';
import 'package:six_jar/features/currency_select/presentation/bloc/currency_selected_bloc.dart';
import 'package:six_jar/features/currency_select/presentation/widgets/six_jar_currency_text_field.dart';

class CurrencySelectScreen extends StatelessWidget {
  const CurrencySelectScreen({super.key});

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
          body: SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Title
                  Text(
                    AppTextConstants.currencySelectTitleText,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // SubTitle
                  Text(
                    AppTextConstants.currencySelectDescriptionText,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: AppColors.textSecondary,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),

                  SizedBox(height: 30.h),

                  // Currency picker svg
                  SvgPicture.asset(
                    AppAssetsConstants.currencyPickerImg,
                    height: 0.4.sh,
                    fit: BoxFit.contain,
                  ),

                  SizedBox(height: 30.h),

                  // BlocBuilder for selected currency
                  BlocBuilder<CurrencySelectedBloc, CurrencySelectedState>(
                    builder: (context, state) {
                      String displayText = "Select your currency";

                      if (state is CurrencySelectedUpdated) {
                        displayText = state.selectedCurrency;
                      }

                      return SixJarCurrencyTextField(
                        displayText: displayText,
                        onTap: () {
                          showCurrencyPicker(
                            context: context,
                            showFlag: true,
                            showCurrencyName: true,
                            showCurrencyCode: true,
                            theme: CurrencyPickerThemeData(
                              titleTextStyle: TextStyle(fontFamily: "Poppins"),
                              subtitleTextStyle: TextStyle(
                                fontFamily: "Poppins",
                              ),
                            ),
                            onSelect: (Currency currency) {
                              // Currency Selected Bloc
                              context.read<CurrencySelectedBloc>().add(
                                CurrencyUserSelectedEvent(
                                  "${currency.name} (${currency.code})",
                                ),
                              );

                              // Logger
                              AppLoggerHelper.logInfo(
                                "💵 Currency Selected Successfully 💵",
                              );
                            },
                          );
                        },
                      );
                    },
                  ),

                  SizedBox(height: 30.h),

                  // countiue btn
                  BlocBuilder<CurrencySelectedBloc, CurrencySelectedState>(
                    builder: (context, state) {
                      if (state is CurrencySelectedUpdated) {
                        return SixJarFilledIconBtn(
                          height: 36.h,
                          width: double.infinity,
                          onPressed: () async {
                            // Hive Currency Selected Status=
                            final currencySelectedBox = Hive.box(
                              AppDbConstants.hiveCurrencyBox,
                            );
                            await currencySelectedBox.put(
                              AppDbConstants.isCurrencySelectedKey,
                              true,
                            );

                            // Read the value
                            final status = currencySelectedBox.get(
                              AppDbConstants.isCurrencySelectedKey,
                            );

                            // Logger
                            AppLoggerHelper.logInfo(
                              "✅ Currency Selected status saved in Hive: $status",
                            );

                            // Home Screen
                            GoRouter.of(
                              context,
                            ).pushReplacementNamed(AppRouteConstants.home.name);
                          },
                          icon: Icons.login_outlined,
                          label: "Continue",
                        );
                      }

                      return SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
