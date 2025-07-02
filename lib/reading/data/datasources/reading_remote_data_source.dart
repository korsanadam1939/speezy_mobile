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
              {"text": "Bana A1 seviyesinde, paragraf boşluğu olmayan ,bir öncekiyle aynı olmayan, çok uzun, farklı ve basit bir İngilizce hikaye yaz. \nHikaye orijinal ve çocuklara hitap eden eğlenceli, öğretici bir konuya sahip olsun.\nSonuç sadece geçerli bir JSON formatında verilsin ve şu şekilde yapılandırılsın:\n\n{\n  \"title\": \"Hikayenin İngilizce başlığı\",\n  \"story\": \"Hikayenin İngilizce metni\",\n  \"translations\": {\n    \"kelime1\": \"Türkçesi\",\n    \"kelime2\": \"Türkçesi\"\n  }\n}\n\nKurallar:\n- \"story\" içinde geçen tüm İngilizce kelimeleri **tek tek** al ve \"translations\" kısmına birebir Türkçe anlamlarıyla yaz.\n- **Deyim, fiil kalıbı veya birleşik ifadeleri** parçalayıp, her kelimeyi ayrı çevir ve kelimeleri küçük harfle ver.  (Örn: \"to play\" ifadesini \"to\": \"-mek için\", \"play\": \"oynamak\" şeklinde ver.)\n- **Zamirler (I, he, she, it, they, we, you), fiiller (is, are, was, play, eat), zarflar (quickly, very, always), edatlar (in, on, at, to, with, from, for, of)** mutlaka listede yer alsın.\n- JSON dışında hiçbir açıklama, etiket veya ek metin yazma.\n\nNot: Hikaye A1 seviyesine uygun, basit ama **oldukça uzun ve farklı** olsun."}
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
