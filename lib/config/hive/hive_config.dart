import 'package:hive_flutter/hive_flutter.dart';
import 'package:six_jar/core/constants/app_db_constants.dart';
import 'package:six_jar/core/helper/app_logger_helper.dart';

class HiveConfig {
  static Future<void> init() async {
    try {
      // Initialize Hive
      await Hive.initFlutter();
      AppLoggerHelper.logInfo("✅ Hive initialized successfully");

      // Auth Hive Box
      await Hive.openBox(AppDbConstants.hiveAuthBox);
      AppLoggerHelper.logInfo("✅ '${AppDbConstants.hiveAuthBox}' box opened");

      // On Boarding Box
      await Hive.openBox(AppDbConstants.hiveOnBoardingBox);
      AppLoggerHelper.logInfo(
        "✅ '${AppDbConstants.hiveOnBoardingBox}' box opened",
      );

      // Currency Box
      await Hive.openBox(AppDbConstants.hiveCurrencyBox);
      AppLoggerHelper.logInfo(
        "✅ '${AppDbConstants.hiveCurrencyBox}' box opened",
      );
    } catch (e) {
      AppLoggerHelper.logError("❌ Hive setup failed: ${e.toString()}");
    }
  }
}
