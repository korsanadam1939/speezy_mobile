import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';
import '../models/role_model.dart';

abstract class RoleLocalDataSource {
  Future<void> cacheRole({required RoleModel? roleToCache});
  Future<RoleModel> getLastRole();
}

const cachedRole = 'CACHED_ROLE';

class RoleLocalDataSourceImpl implements RoleLocalDataSource {
  final SharedPreferences sharedPreferences;


  RoleLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<RoleModel> getLastRole() async {

    final jsonString = await sharedPreferences.getString(cachedRole);
    print(jsonString);

    if (jsonString != null) {
      print("geylastory---------------");
      print(Future.value(RoleModel.fromJson(json: json.decode(jsonString))));
      return Future.value(RoleModel.fromJson(json: json.decode(jsonString)));
    } else {

      print("veri yok");
      return RoleModel(senorio: "TEKRAR GİR ÇIK YAPIN", title: "DENEME", your_task: "S", translations: {}, title_emoji: "AA", role_emoji: "SADSD");
      throw CacheException();

    }
  }

  @override
  Future<void> cacheRole({required RoleModel? roleToCache}) async {
    print(roleToCache?.senorio);
    if (roleToCache != null) {
      print("veri kaydedildi ");
      print(roleToCache.senorio);
      await sharedPreferences.setString(
        cachedRole,
        json.encode(
          roleToCache.toJson(),
        ),
      );
    } else {
      print("veri boş");
      throw CacheException();
    }
  }
}
