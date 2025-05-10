import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speezy_mobile/utils/preference_keys.dart';
import '../models/user-model.dart';
import 'storage_service.dart';

class SharedPreferencesService extends ChangeNotifier implements StorageService  {
  @override
  Future<void> saveToken({required String refreshtoken}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(PreferenceKeys.refreshToken, refreshtoken);


  }

  @override
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();



    final String? refreshToken = prefs.getString(PreferenceKeys.refreshToken) ;

    return  refreshToken;
  }


  @override
  Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(PreferenceKeys.refreshToken);
  }
  
  Future<void> saveUser(User user) async {
    print(user.rank);
    print(user.id);
    print(user.level);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", user.username!);
    await prefs.setString("email", user.email!);
    await prefs.setInt("xp", user.totalXp!);
    await prefs.setString("id", user.id!);
    await prefs.setString("rank", user.rank!);
    await prefs.setString("level", user.level!);
    
    
    
  }

  Future<User> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    
    String? username = await prefs.getString("username");
    String? email = await prefs.getString("email");
    int? xp =await prefs.getInt("xp");
    String? id = await prefs.getString("id");
    String? rank = await prefs.getString("rank");
    String? level = await prefs.getString("level");

    print(username);
    print(id);
    
    return User(id: id, username: username, email: email, level: level, rank: rank, totalXp: xp, gems: 0, streakCount: 0, lastActiveDate: "0.0.0", isPremium: false, accountStatus: "active");



  }

}
