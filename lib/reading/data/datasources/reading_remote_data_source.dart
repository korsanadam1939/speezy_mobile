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
              {"text": "Bana A1 seviyesinde, çocuklar için uygun, uzun ve basit bir İngilizce hikaye ver. Sonuç sadece geçerli bir JSON formatında olsun ve şu şekilde yapılandırılsın:\n\n{\n  \"title\": \"Hikayenin İngilizce başlığı\",\n  \"story\": \"Hikayenin İngilizce metni\",\n  \"translations\": {\n    \"kelime1\": \"Türkçesi\",\n    \"kelime2\": \"Türkçesi\"\n  }\n}\n\nKurallar:\n- \"story\" içinde geçen İngilizce kelimeleri **tek tek** al ve \"translations\" içinde birebir Türkçe anlamlarını yaz.\n- \"to play\" gibi ifadeleri parçalayıp ayrı ayrı ver. (\"to\": \"-mek için\", \"play\": \"oynamak\")\n- Zamirler, fiiller, zarflar, edatlar (örn. is, to, opens, this, time, good, night) mutlaka yer alsın.\n- JSON dışında hiçbir şey yazma. Açıklama, ```json gibi etiket kullanma."}
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
