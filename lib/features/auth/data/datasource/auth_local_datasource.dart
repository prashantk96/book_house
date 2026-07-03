import 'package:book_house/core/services/local_storage_service.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthLocalDatasource {
  final LocalStorageService storage;

  AuthLocalDatasource(this.storage);

  Future<void> saveUid(String uid) async {
    await storage.save('uid', uid);
  }

  Future<String?> getUid() async {
    return storage.read('uid');
  }

  Future<void> clear() async {
    await storage.remove('uid');
  }
}
