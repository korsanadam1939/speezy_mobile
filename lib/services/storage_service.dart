abstract class StorageService {
  Future<void> saveToken({required String accestoken, required String refreshtoken});
  Future<List<String?>> getToken();
  Future<void> clearToken();
}
