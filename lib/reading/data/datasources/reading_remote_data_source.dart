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
    final response = await dio.get(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyCUuwt1DRn-vYGTyoQrJqyeEpeh_EOju5w',
      queryParameters: {
        'api_key': 'if you need',
      },
    );

    if (response.statusCode == 200) {
      return ReadingModel.fromJson(json: response.data);
    } else {
      throw ServerException();
    }


  }
}
