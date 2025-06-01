import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:six_jar/commons/Widgets/six_jar_filled_icon_btn.dart';
import 'package:six_jar/commons/Widgets/six_jar_text_btn_field.dart';
import 'package:six_jar/commons/Widgets/six_jar_text_field.dart';
import 'package:six_jar/core/blocs/connectivity_bloc/connectivity_bloc.dart';
import 'package:six_jar/core/constants/app_text_constants.dart';
import 'package:six_jar/core/helper/app_logger_helper.dart';
import 'package:six_jar/core/helper/app_snack_bar_helper.dart';
import 'package:six_jar/core/helper/app_validators_helper.dart';
import 'package:six_jar/core/theme/app_colors.dart';

class AuthForgetPasswordScreen extends StatefulWidget {
  const AuthForgetPasswordScreen({super.key});

  @override
  State<AuthForgetPasswordScreen> createState() =>
      _AuthForgetPasswordScreenState();
}

class _AuthForgetPasswordScreenState extends State<AuthForgetPasswordScreen> {
  // form key
  final GlobalKey<FormState> formForgetPasswordKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController emailAuthForgetPasswordController =
      TextEditingController();

  @override
  void dispose() {
    emailAuthForgetPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // Connectivity Bloc
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
                  message:  AppTextConstants.internetSuccessText,
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
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Reset Password Text
                    Text(
                      AppTextConstants.resetPasswordText,
                      style: Theme.of(context).textTheme.headlineLarge
                          ?.copyWith(
                            color: AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                    ),

                    SizedBox(height: 8.h),

                    // Reset Password Description Text
                    Text(
                      AppTextConstants.resetPasswordDescriptionText,
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
                            controller: emailAuthForgetPasswordController,
                            validator: (value) =>
                                AppValidatorHelper.validateEmail(value),
                            keyboardType: TextInputType.emailAddress,
                            hint: AppTextConstants.emailHintTextFieldText,
                            prefixIcon: Icons.alternate_email_outlined,
                            autoFillHints: const [AutofillHints.email],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 30.h),

                    // Sign In Btn
                    SixJarFilledIconBtn(
                      height: 38.h,
                      width: double.infinity,
                      onPressed: () {
                        if (formForgetPasswordKey.currentState!.validate()) {
                          AppLoggerHelper.logInfo(
                            "Form is valid. Proceed to send link...",
                          );

                          // Add your login logic here
                        } else {
                          AppLoggerHelper.logError("Form is invalid.");
                        }
                      },
                      icon: Icons.link_outlined,
                      label: AppTextConstants.sentResetLinkText,
                    ),

                    SizedBox(height: 18.h),

                    // Back to sign in
                    Align(
                      alignment: Alignment.center,
                      child: SixJarTextBtn(
                        text: "Back to Sign In",
                        onPressed: () {
                          GoRouter.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
