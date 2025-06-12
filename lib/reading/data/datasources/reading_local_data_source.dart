import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/errors/exceptions.dart';
import '../models/reading_model.dart';

abstract class ReadingLocalDataSource {
  Future<void> cacheStory({required ReadingModel? storyToCache});
  Future<ReadingModel> getLastStory();
}

const cachedStory = 'CACHED_STORY';

class ReadingLocalDataSourceImpl implements ReadingLocalDataSource {
  final SharedPreferences sharedPreferences;


  ReadingLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<ReadingModel> getLastStory() {
    final jsonString = sharedPreferences.getString(cachedStory);

    if (jsonString != null) { 
      return Future.value(ReadingModel.fromJson(json: json.decode(jsonString)));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheStory({required ReadingModel? storyToCache}) async {
    if (storyToCache != null) {
      sharedPreferences.setString(
        cachedStory,
        json.encode(
          storyToCache.toJson(),
        ),
      );
    } else {
      throw CacheException();
    }
  }
}
