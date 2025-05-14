import 'package:six_jar/core/constants/app_text_constants.dart';

class AppValidatorHelper {
  /// Validates username
  static String? validateUsername(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppTextConstants.usernameRequired;
    }
    if (value.trim().length < 3) {
      return AppTextConstants.usernameTooShort;
    }
    return null;
  }

  /// Validates email address
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppTextConstants.emailRequired;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) {
      return AppTextConstants.emailInvalid;
    }
    return null;
  }

  /// Validates password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return AppTextConstants.passwordRequired;
    }
    if (value.length < 6) {
      return AppTextConstants.passwordTooShort;
    }
    return null;
  }
}
