import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';
import '../models/answer_model.dart';

abstract class AnswerLocalDataSource {
  Future<void> cacheAnswer({required AnswerModel? answerToCache});
  Future<AnswerModel> getLastAnswer();
}

const cachedAnswer = 'CACHED_ANSWER';

class AnswerLocalDataSourceImpl implements AnswerLocalDataSource {
  final SharedPreferences sharedPreferences;


  AnswerLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<AnswerModel> getLastAnswer() async {

    final jsonString = await sharedPreferences.getString(cachedAnswer);
    print(jsonString);

    if (jsonString != null) {
      print("geylastory---------------");
      print(Future.value(AnswerModel.fromJson(json: json.decode(jsonString))));
      return Future.value(AnswerModel.fromJson(json: json.decode(jsonString)));
    } else {

      print("veri yok");

      throw CacheException();

    }
  }

  @override
  Future<void> cacheAnswer({required AnswerModel? answerToCache}) async {

    if (answerToCache != null) {
      print("veri kaydedildi ");

      await sharedPreferences.setString(
        cachedAnswer,
        json.encode(
          answerToCache.toJson(),
        ),
      );
    } else {
      print("veri boş");
      throw CacheException();
    }
  }
}
