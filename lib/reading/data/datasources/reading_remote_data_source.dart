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
              {"text": "bana a1 seviye ingilizce bir hikaye ver "}
            ]
          }
        ]
      },
    );

    if (response.statusCode == 200) {
      return ReadingModel.fromJson(json: response.data);
    } else {
      throw ServerException();
    }


  }
}
