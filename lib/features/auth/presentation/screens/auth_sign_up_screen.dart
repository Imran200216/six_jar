import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:six_jar/commons/Widgets/six_jar_filled_icon_btn.dart';
import 'package:six_jar/commons/Widgets/six_jar_outlined_icon_btn.dart';
import 'package:six_jar/commons/Widgets/six_jar_text_field.dart';
import 'package:six_jar/core/constants/app_assets.constants.dart';
import 'package:six_jar/core/constants/app_router_constants.dart';
import 'package:six_jar/core/constants/app_text_constants.dart';
import 'package:six_jar/core/helper/app_logger_helper.dart';
import 'package:six_jar/core/helper/app_validators_helper.dart';
import 'package:six_jar/core/theme/app_colors.dart';
import 'package:six_jar/features/auth/presentation/widgets/auth_divider_content.dart';
import 'package:six_jar/features/auth/presentation/widgets/auth_footer.dart';

class AuthSignUpScreen extends StatefulWidget {
  const AuthSignUpScreen({super.key});

  @override
  State<AuthSignUpScreen> createState() => _AuthSignUpScreenState();
}

class _AuthSignUpScreenState extends State<AuthSignUpScreen> {
  // form key
  final GlobalKey<FormState> formSignUpKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController userNameAuthSignUpController =
      TextEditingController();

  final TextEditingController emailAuthSignUpController =
      TextEditingController();

  final TextEditingController passwordAuthSignUpController =
      TextEditingController();

  @override
  void dispose() {
    userNameAuthSignUpController.dispose();
    emailAuthSignUpController.dispose();
    passwordAuthSignUpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 30.h),
            child: Form(
              key: formSignUpKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Sign Up Text
                  Text(
                    AppTextConstants.signUpText,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  // description
                  Text(
                    AppTextConstants.signUpDescriptionText,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
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
                        // username textfield
                        SixJarTextField(
                          textFieldLabel: AppTextConstants.userNameLabelText,
                          controller: userNameAuthSignUpController,
                          validator: (value) =>
                              AppValidatorHelper.validateUsername(value),
                          keyboardType: TextInputType.name,
                          hint: AppTextConstants.userNameHintTextFieldText,
                          prefixIcon: Icons.person_outline_outlined,
                          autoFillHints: const [
                            AutofillHints.name,
                            AutofillHints.username,
                          ],
                        ),

                        SizedBox(height: 20.h),

                        // email textfield
                        SixJarTextField(
                          textFieldLabel: AppTextConstants.emailLabelText,
                          controller: emailAuthSignUpController,
                          validator: (value) =>
                              AppValidatorHelper.validateEmail(value),
                          keyboardType: TextInputType.emailAddress,
                          hint: AppTextConstants.emailHintTextFieldText,
                          prefixIcon: Icons.alternate_email_outlined,
                          autoFillHints: const [AutofillHints.email],
                        ),

                        SizedBox(height: 20.h),

                        // password textfield
                        SixJarTextField(
                          textFieldLabel: AppTextConstants.passwordLabelText,
                          controller: passwordAuthSignUpController,
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

                  // Sign Up Btn
                  SixJarFilledIconBtn(
                    height: 38.h,
                    width: double.infinity,
                    onPressed: () {
                      if (formSignUpKey.currentState!.validate()) {
                        AppLoggerHelper.logInfo(
                          "Form is valid. Proceed to sign up...",
                        );

                        // Add your login logic here
                      } else {
                        AppLoggerHelper.logError("Form is invalid.");
                      }
                    },
                    icon: Icons.login,
                    label: AppTextConstants.createAccountText,
                  ),

                  SizedBox(height: 18.h),

                  // Auth Divider Content
                  AuthDividerContent(
                    dividerTextContent: AppTextConstants.orSignUpWithText,
                  ),

                  SizedBox(height: 18.h),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20.w,
                    children: [
                      // Google Auth Btn
                      Expanded(
                        child: SixJarOutlinedIconBtn(
                          onPressed: () {},
                          svgAssetPath: AppAssetsConstants.googleAuthIcon,
                          label: AppTextConstants.googleText,
                        ),
                      ),

                      // Apple Auth Btn
                      Expanded(
                        child: SixJarOutlinedIconBtn(
                          onPressed: () {},
                          svgAssetPath: AppAssetsConstants.appleAuthIcon,
                          label: AppTextConstants.appleText,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // sign in
                  AuthFooter(
                    descriptionText: AppTextConstants.alreadyHaveAnAccountText,
                    textBtnTitle: AppTextConstants.signInText,
                    textBtnOnTap: () {
                      // sign up screen
                      GoRouter.of(
                        context,
                      ).pushNamed(AppRouteConstants.authLogin.name);
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
