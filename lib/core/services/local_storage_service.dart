import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LocalStorageService {
  static const _boxName = 'app';
  static const _onboardingKey = 'onboarding_completed';

  Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_boxName);
  }

  Future<void> save(String key, dynamic value) async {
    final box = Hive.box(_boxName);
    await box.put(key, value);
  }

  Future<T?> read<T>(String key) async {
    final box = Hive.box(_boxName);
    return box.get(key);
  }

  Future<void> remove(String key) async {
    final box = Hive.box(_boxName);
    await box.delete(key);
  }

  // Onboarding helpers
  Future<void> completeOnboarding() async {
    await save(_onboardingKey, true);
  }

  Future<bool> isOnboardingCompleted() async {
    return await read<bool>(_onboardingKey) ?? false;
  }
}
