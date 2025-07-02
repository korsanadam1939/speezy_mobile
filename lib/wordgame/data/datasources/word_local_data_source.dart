import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';
import '../models/word_model.dart';

abstract class WordLocalDataSource {
  Future<void> cacheWord({required WordModel? wordToCache});
  Future<WordModel> getLastWord();
}

const cachedWord = 'CACHED_WORD';

class WordLocalDataSourceImpl implements WordLocalDataSource {
  final SharedPreferences sharedPreferences;


  WordLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<WordModel> getLastWord() {
    final jsonString = sharedPreferences.getString(cachedWord);

    if (jsonString != null) { 
      return Future.value(WordModel.fromJson(json: json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheWord({required WordModel? wordToCache}) async {
    if (wordToCache != null) {
      sharedPreferences.setString(
        cachedWord,
        json.encode(
          wordToCache.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}
