import 'dart:convert';

import 'package:dio/dio.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/params/params.dart';
import '../models/word_model.dart';

abstract class WordRemoteDataSource {
  Future<WordModel> getWord({required WordParams wordParams});
}

class WordRemoteDataSourceImpl implements WordRemoteDataSource {
  final Dio dio;

  WordRemoteDataSourceImpl({required this.dio});

  @override
  Future<WordModel> getWord({required WordParams wordParams}) async {

    final response = await dio.get(
      'https://5000-idx-speezy-1744655613575.cluster-jbb3mjctu5cbgsi6hwq6u4btwe.cloudworkstations.dev/api/pool/words/A1',
      queryParameters: {
        'api_key': 'if you need',
      },
    );
    print("deneme1");

    if (response.statusCode == 200) {

      print(response.data);
      print("-----");
      print(response.data['data']['wordGroups']);
      for (var group in response.data['data']['wordGroups']) {
        print(group);
      }







      return WordModel.fromJson(json: response.data['data']);

    } else {
      print("deneme");
      throw ServerException();
    }


  }
}
