import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:speezy_mobile/services/storage_service.dart';

class AuthService {
  final StorageService _storageService;
  final Dio _dio = Dio();
  final String _baseUrl = 'https://5000-idx-speezy-1744655613575.cluster-jbb3mjctu5cbgsi6hwq6u4btwe.cloudworkstations.dev/api/auth/login';

  AuthService(this._storageService);

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  Future<Map<String?, String?>?> login({required String email, required String password}) async {


    try {
      final response = await _dio.post("https://5000-idx-speezy-1744655613575.cluster-jbb3mjctu5cbgsi6hwq6u4btwe.cloudworkstations.dev/api/auth/login", data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        String? accestoken = response.data['data']['accessToken'];
        String? refresstoken = response.data['data']['refreshToken'];
        String? username = response.data['data']['user']['username'];




        if(accestoken != null || refresstoken != null) {

          return {
            "accestoken" : accestoken,
            "refresstoken" : refresstoken,
            "username" : username

          };
        }


      }

      else {

        throw Exception('Login failed');
        return null;
      }
    }catch(e) {

      // Handle error
    }
    _isLoggedIn = true;
  }

  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        "https://5000-idx-speezy-1744655613575.cluster-jbb3mjctu5cbgsi6hwq6u4btwe.cloudworkstations.dev/api/auth/register",
        data: {
          "username": username,
          "email": email,
          "password": password,
        },
        options: Options(
          validateStatus: (status) {
            // 500 ve üstü hariç tüm status kodlarını response olarak kabul et
            return status != null && status < 500;
          },
        ),
      );

      // Eğer 400 dönerse ve success false ise
      if (response.statusCode == 400) {
        return {
          "durum": false,
          "error": response.data["message"] ?? "Bilinmeyen bir hata oluştu.",
        };
      }

      // Eğer 200/201 ise başarılı
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "durum": true,
          "data": response.data,
        };
      }

      // Diğer durumlar
      return {
        "durum": false,
        "error": "Beklenmeyen bir hata oluştu. Kod: ${response.statusCode}",
      };
    } catch (e) {
      print('Register error: $e');
      return {
        "durum": false,
        "error": "Bir hata oluştu: $e",
      };
    }
  }

  Future<bool> sendcode({
    required String email,
  }) async {
    try {
      final response = await _dio.post(
        "https://5000-idx-speezy-1744655613575.cluster-jbb3mjctu5cbgsi6hwq6u4btwe.cloudworkstations.dev/api/auth/forgot-password",
        data: {
          "email": email,
        },
        options: Options(
          contentType: Headers.jsonContentType, // <-- bunu da ekleyelim
          validateStatus: (status) {
            return status != null && status < 500;
          },
        ),
      );

      if (response.statusCode == 400) {
        return false;
      }

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }

      return false;
    } catch (e) {
      print('Register error: $e');
      return false;
    }
  }

  Future<Map<String, dynamic>> changethepassword({

    required String email,
    required String code,

    required String password,
  }) async {
    try {
      final response = await _dio.post(
        "https://5000-idx-speezy-1744655613575.cluster-jbb3mjctu5cbgsi6hwq6u4btwe.cloudworkstations.dev/api/auth/reset-password",
        data: {
          "email": email,
          "otp": code,
          "newPassword": password
        },
        options: Options(
          validateStatus: (status) {
            // 500 ve üstü hariç tüm status kodlarını response olarak kabul et
            return status != null && status < 500;
          },
        ),
      );

      // Eğer 400 dönerse ve success false ise
      if (response.statusCode == 400) {
        return {
          "durum": false,
          "error": response.data["message"] ?? "Bilinmeyen bir hata oluştu.",
        };
      }

      // Eğer 200/201 ise başarılı
      if (response.statusCode == 200 || response.statusCode == 201) {
        return {
          "durum": true,
          "data": response.data,
        };
      }

      // Diğer durumlar
      return {
        "durum": false,
        "error": "Beklenmeyen bir hata oluştu. Kod: ${response.statusCode}",
      };
    } catch (e) {
      print('Register error: $e');
      return {
        "durum": false,
        "error": "Bir hata oluştu: $e",
      };
    }
  }








  void logout() {
    _isLoggedIn = false;
  }
}