import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:six_jar/core/helper/app_logger_helper.dart';

@lazySingleton
class HiveService {
  // Auth Status Box
  late Box<bool> _authStatusBox;
  // OnBoarding Status Box
  late Box<bool> _onBoardingStatusBox;
  // Currency Selected Status Box
  late Box<bool> _onCurrencySelectedStatusBox;

  Future<void> init() async {
    // initialize flutter
    await Hive.initFlutter();

    // Open boxes, specify type as bool to enforce type safety
    _authStatusBox = await Hive.openBox<bool>('authStatusBox');
    _onBoardingStatusBox = await Hive.openBox<bool>('onBoardingStatusBox');
    _onCurrencySelectedStatusBox = await Hive.openBox<bool>(
      'onCurrencySelectedStatusBox',
    );

    // Initialize defaults if not set yet
    if (!_authStatusBox.containsKey('isLoggedIn')) {
      await _authStatusBox.put('isLoggedIn', false);
    }
    if (!_onBoardingStatusBox.containsKey('isCompleted')) {
      await _onBoardingStatusBox.put('isCompleted', false);
    }
    if (!_onCurrencySelectedStatusBox.containsKey('isCurrencySelected')) {
      await _onCurrencySelectedStatusBox.put('isCurrencySelected', false);
    }

    // Log success
    AppLoggerHelper.logInfo(
      '💥 HiveService: Hive boxes initialized successfully 💥',
    );
  }

  // Read auth status
  bool get isLoggedIn => _authStatusBox.get('isLoggedIn', defaultValue: false)!;

  // Set auth status
  Future<void> setLoggedIn(bool value) async {
    await _authStatusBox.put('isLoggedIn', value);
  }

  // Read onboarding status
  bool get isOnBoardingCompleted =>
      _onBoardingStatusBox.get('isCompleted', defaultValue: false)!;

  // Set onboarding status
  Future<void> setOnBoardingCompleted(bool value) async {
    await _onBoardingStatusBox.put('isCompleted', value);
  }

  // Read currency selected status
  bool get isCurrencySelected => _onCurrencySelectedStatusBox.get(
    'isCurrencySelected',
    defaultValue: false,
  )!;

  // Set currency selected status
  Future<void> setCurrencySelected(bool value) async {
    await _onCurrencySelectedStatusBox.put('isCurrencySelected', value);
  }

  // Clear statuses if needed
  Future<void> clearAuthStatus() async {
    await _authStatusBox.put('isLoggedIn', false);
  }

  Future<void> clearOnBoardingStatus() async {
    await _onBoardingStatusBox.put('isCompleted', false);
  }

  // Clear currency selected status
  Future<void> clearCurrencySelectedStatus() async {
    await _onCurrencySelectedStatusBox.put('isCurrencySelected', false);
  }
}
