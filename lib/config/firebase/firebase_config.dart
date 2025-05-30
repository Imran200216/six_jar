import 'package:firebase_core/firebase_core.dart';
import 'package:six_jar/core/helper/app_logger_helper.dart';
import 'package:six_jar/firebase_options.dart';

class FirebaseConfig {
  static Future<void> init() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      AppLoggerHelper.logInfo("✅ Firebase initialized successfully");
    } catch (e) {
      AppLoggerHelper.logError("❌ Firebase initialization failed: $e");
      rethrow;
    }
  }
}
