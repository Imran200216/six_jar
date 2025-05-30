import 'package:mongo_dart/mongo_dart.dart';
import 'package:six_jar/core/helper/app_logger_helper.dart';

class MongoDbConfig {
  static const _mongoConnectionUrl = 'mongodb+srv://<username>:<password>@<cluster-url>/<dbname>?retryWrites=true&w=majority';

  late Db _db;
  late DbCollection _userCollection;

  Future<void> connect() async {
    try {
      _db = await Db.create(_mongoConnectionUrl);
      await _db.open();
      _userCollection = _db.collection('users');
      AppLoggerHelper.logInfo("✅ Connected to MongoDB and accessed 'users' collection");
    } catch (e) {
      AppLoggerHelper.logError("❌ Failed to connect to MongoDB: $e");
      rethrow;
    }
  }

  Future<void> insertUser(Map<String, dynamic> userData) async {
    try {
      await _userCollection.insert(userData);
      AppLoggerHelper.logInfo("✅ User inserted into MongoDB: ${userData['userUid'] ?? 'No UID'}");
    } catch (e) {
      AppLoggerHelper.logError("❌ Failed to insert user into MongoDB: $e");
    }
  }

  Future<void> close() async {
    try {
      await _db.close();
      AppLoggerHelper.logInfo("✅ MongoDB connection closed");
    } catch (e) {
      AppLoggerHelper.logError("❌ Failed to close MongoDB connection: $e");
    }
  }
}
