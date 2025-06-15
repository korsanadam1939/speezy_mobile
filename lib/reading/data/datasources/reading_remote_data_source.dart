import 'dart:convert';

import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/params/params.dart';
import '../models/reading_model.dart';

abstract class ReadingRemoteDataSource {
  Future<ReadingModel> getStory({required ReadingParams readingParams});
}

class ReadingRemoteDataSourceImpl implements ReadingRemoteDataSource {
  final Dio dio;

  ReadingRemoteDataSourceImpl({required this.dio});

  @override
  Future<ReadingModel> getStory({required ReadingParams readingParams}) async {
    Response? response;
    response = await dio.post(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyCLJ2xXD3bo8EXg6Cpz24ZX7wzUjFxYAWQ',
      options: Options(headers: {
        'Content-Type': 'application/json',
      }),
      data: {
        "contents": [
          {
            "parts": [
              {"text": "bana a1 seviye ingilizce çok farklı bir hikaye ver ama sadece hikayeyi ver json formatında title ve story diye ve sadece json veriyi ver başına felan json yazma"}
            ]
          }
        ]
      },
    );

    if (response.statusCode == 200) {
      print(response.data);
      final storyText = response.data['candidates'][0]['content']['parts'][0]['text'];
      final cleanStoryText = storyText.replaceAll('```json', '').replaceAll('```', '').trim();
      print("veri tipi ${storyText.runtimeType}");

      print(storyText);
      var storyJson =jsonDecode(cleanStoryText);
      print(storyJson);


      return ReadingModel.fromJson(json: storyJson);

    } else {
      print("deneme");
      throw ServerException();
    }


  }
}
