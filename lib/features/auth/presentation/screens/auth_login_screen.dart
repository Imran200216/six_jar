import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:six_jar/commons/Widgets/six_jar_filled_icon_btn.dart';
import 'package:six_jar/commons/Widgets/six_jar_outlined_icon_btn.dart';
import 'package:six_jar/commons/Widgets/six_jar_text_btn_field.dart';
import 'package:six_jar/commons/Widgets/six_jar_text_field.dart';
import 'package:six_jar/commons/bloc/connectivity_bloc.dart';
import 'package:six_jar/core/constants/app_assets.constants.dart';
import 'package:six_jar/core/constants/app_router_constants.dart';
import 'package:six_jar/core/constants/app_text_constants.dart';
import 'package:six_jar/core/di/injectable.dart';
import 'package:six_jar/core/helper/app_logger_helper.dart';
import 'package:six_jar/core/helper/app_snack_bar_helper.dart';
import 'package:six_jar/core/helper/app_validators_helper.dart';
import 'package:six_jar/core/service/hive_service.dart';
import 'package:six_jar/core/theme/app_colors.dart';
import 'package:six_jar/features/auth/presentation/widgets/auth_divider_content.dart';
import 'package:six_jar/features/auth/presentation/widgets/auth_footer.dart';

class AuthLoginScreen extends StatefulWidget {
  const AuthLoginScreen({super.key});

  @override
  State<AuthLoginScreen> createState() => _AuthLoginScreenState();
}

class _AuthLoginScreenState extends State<AuthLoginScreen> {
  // form key
  final GlobalKey<FormState> formLoginKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController emailAuthLoignController =
      TextEditingController();

  final TextEditingController passwordAuthLoginController =
      TextEditingController();

  @override
  void dispose() {
    emailAuthLoignController.dispose();
    passwordAuthLoginController.dispose();
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
          body: SafeArea(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
                child: Form(
                  key: formLoginKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // Sign In Text
                      Text(
                        AppTextConstants.signInText,
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w600,
                              fontSize: 24,
                            ),
                      ),

                      SizedBox(height: 8.h),

                      // description
                      Text(
                        AppTextConstants.sixJarAuthLoginDescriptionText,
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(
                              color: AppColors.textSecondary,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                      ),

                      SizedBox(height: 30.h),

                      // Autofill group for email & password
                      AutofillGroup(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // email textfield
                            SixJarTextField(
                              textFieldLabel: AppTextConstants.emailLabelText,
                              controller: emailAuthLoignController,
                              validator: (value) =>
                                  AppValidatorHelper.validateEmail(value),
                              keyboardType: TextInputType.emailAddress,
                              hint: AppTextConstants.emailHintTextFieldText,
                              prefixIcon: Icons.alternate_email_outlined,
                              autoFillHints: const [AutofillHints.email],
                            ),

                            SizedBox(height: 20.h),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Password text
                                Text(
                                  AppTextConstants.passwordLabelText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(
                                        color: AppColors.textPrimary,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                      ),
                                ),

                                // Forget Password text Btn
                                SixJarTextBtn(
                                  text: "Forget Password?",
                                  onPressed: () {
                                    // Forget Password Screen
                                    GoRouter.of(context).pushNamed(
                                      AppRouteConstants.authForgetPassword.name,
                                    );
                                  },
                                ),
                              ],
                            ),

                            SizedBox(height: 8.h),

                            // password textfield
                            SixJarTextField(
                              controller: passwordAuthLoginController,
                              validator: (value) =>
                                  AppValidatorHelper.validatePassword(value),
                              keyboardType: TextInputType.visiblePassword,
                              hint: AppTextConstants.passwordHintTextFieldText,
                              prefixIcon: Icons.lock_outline,
                              isPassword: true,
                              autoFillHints: const [
                                AutofillHints.password,
                                AutofillHints.newPassword,
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 30.h),

                      // Sign In Btn
                      SixJarFilledIconBtn(
                        height: 38.h,
                        width: double.infinity,
                        onPressed: () async {
                          if (formLoginKey.currentState!.validate()) {
                            // Form Logger
                            AppLoggerHelper.logInfo(
                              "Form is valid. Proceed to login...",
                            );

                            // Auth Email Login Logic

                            // Hive Auth Logged Status
                            final hiveService = getIt<HiveService>();
                            await hiveService.setLoggedIn(true);

                            // Logger
                            AppLoggerHelper.logInfo(
                              "✅ Auth Logged status saved in Hive.",
                            );

                            // Home Screen
                            GoRouter.of(
                              context,
                            ).pushReplacementNamed(AppRouteConstants.home.name);
                          } else {
                            AppLoggerHelper.logError("Form is invalid.");
                          }
                        },
                        icon: Icons.login,
                        label: AppTextConstants.signInText,
                      ),

                      SizedBox(height: 18.h),

                      // Auth Divider Content
                      AuthDividerContent(
                        dividerTextContent: AppTextConstants.orContinueWithText,
                      ),

                      SizedBox(height: 18.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 20.w,
                        children: [
                          // Google Auth Btn
                          Expanded(
                            child: SixJarOutlinedIconBtn(
                              onPressed: () async {
                                // Auth Google Login Logic

                                // Hive Auth Logged Status
                                final hiveService = getIt<HiveService>();
                                await hiveService.setLoggedIn(true);

                                // Logger
                                AppLoggerHelper.logInfo(
                                  "✅ Auth Logged status saved in Hive.",
                                );

                                // Home Screen
                                GoRouter.of(context).pushReplacementNamed(
                                  AppRouteConstants.home.name,
                                );
                              },
                              svgAssetPath: AppAssetsConstants.googleAuthIcon,
                              label: AppTextConstants.googleText,
                            ),
                          ),

                          // Apple Auth Btn
                          Expanded(
                            child: SixJarOutlinedIconBtn(
                              onPressed: () async {
                                // Auth Apple Login Logic

                                // Hive Auth Logged Status
                                final hiveService = getIt<HiveService>();
                                await hiveService.setLoggedIn(true);

                                // Logger
                                AppLoggerHelper.logInfo(
                                  "✅ Auth Logged status saved in Hive.",
                                );

                                // Home Screen
                                GoRouter.of(context).pushReplacementNamed(
                                  AppRouteConstants.home.name,
                                );
                              },
                              svgAssetPath: AppAssetsConstants.appleAuthIcon,
                              label: AppTextConstants.appleText,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      // sign up
                      AuthFooter(
                        descriptionText: AppTextConstants.dontHaveAnAccountText,
                        textBtnTitle: AppTextConstants.createAccountText,
                        textBtnOnTap: () {
                          // sign up screen
                          GoRouter.of(
                            context,
                          ).pushNamed(AppRouteConstants.authSignUp.name);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
