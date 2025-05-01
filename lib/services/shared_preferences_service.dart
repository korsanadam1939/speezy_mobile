import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speezy_mobile/utils/preference_keys.dart';
import 'storage_service.dart';

class SharedPreferencesService extends ChangeNotifier implements StorageService  {
  @override
  Future<void> saveToken({required String accestoken,required String refreshtoken}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(PreferenceKeys.accessToken, accestoken);
    await prefs.setString(PreferenceKeys.refreshToken, refreshtoken);


  }

  @override
  Future<List<String?>> getToken() async {
    final prefs = await SharedPreferences.getInstance();

    final String?  accessToken = prefs.getString(PreferenceKeys.accessToken) ;
    final String? refreshToken = prefs.getString(PreferenceKeys.refreshToken) ;

    return [accessToken, refreshToken];
  }


  @override
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(PreferenceKeys.refreshToken);
  }

}
