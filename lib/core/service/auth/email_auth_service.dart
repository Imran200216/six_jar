import 'package:firebase_auth/firebase_auth.dart';
import 'package:six_jar/config/mango_db/mongo_db_config.dart';
import 'package:six_jar/core/helper/app_logger_helper.dart';
import 'package:six_jar/core/models/user_model.dart';

class EmailAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final MongoDbConfig _mongoService = MongoDbConfig();

  Future<UserCredential?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String userName,
    String? age,
    String? address,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = credential.user;

      if (user != null) {
        await user.updateDisplayName(userName);
        await user.reload();

        final newUser = UserModel(
          userName: userName,
          userEmail: email,
          userUid: user.uid,
        );

        // Connect to MongoDB and insert user data
        await _mongoService.connect();
        await _mongoService.insertUser(newUser.toJson());
        await _mongoService.close();

        AppLoggerHelper.logInfo(
          "✅ User created and stored in MongoDB: ${user.uid}",
        );
      }

      return credential;
    } on FirebaseAuthException catch (e) {
      AppLoggerHelper.logError("❌ FirebaseAuthException: ${e.message}");
      return null;
    } catch (e) {
      AppLoggerHelper.logError("❌ Unknown error: $e");
      return null;
    }
  }
}
