import 'package:speezy_mobile/models/user-model.dart';

abstract class StorageService {
  Future<void> saveToken({required String refreshtoken});
  Future<String?> getToken();
  Future<void> clearToken();
  Future<void> saveUser(User user);
  Future<User> loadUser();
}
