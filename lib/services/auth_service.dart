import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:either_dart/either.dart';
import 'package:speezy_mobile/models/eror_model.dart';
import 'package:speezy_mobile/services/storage_service.dart';
import 'package:speezy_mobile/utils/preference_keys.dart';

import '../models/user-model.dart';

class AuthService {
  final StorageService _storageService;
  final Dio _dio = Dio();


  AuthService(this._storageService);

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;



  Future<User?> login(String email, String password) async {
    try {
      final response = await _dio.post("${PreferenceKeys.baseUrl}/login", data: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        final data = response.data;
        final user = User.fromJson(data['data']['user']);
        print(user.username);
        await _storageService.saveToken(refreshtoken: data['data']['refreshToken']);
        await _storageService.saveUser(user);
        return user;
      } else {
        return null;
      }

    } catch (e) {

      return null;
    }
  }



  Future<ErrorModel?> register({
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

            return status != null && status < 500;
          },
        ),
      );
      if (response.statusCode == 400) {
        final error = ErrorModel.fromJson(response.data);
        return error;
      }
      if (response.statusCode == 200 || response.statusCode == 201) {
        return null;
      }
      return ErrorModel(message: "Beklenmeyen bir hata oluştu");
    } catch (e) {
      print('Register error: $e');
      return ErrorModel(message: e.toString());
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
          contentType: Headers.jsonContentType,
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

  Future<bool> changethepassword({

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
        return false;
      }

      // Eğer 200/201 ise başarılı
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }

      // Diğer durumlar
     return false;
    } catch (e) {
      print('Register error: $e');
      return false;
    }
  }








  void logout() {

    _isLoggedIn = false;
  }
}