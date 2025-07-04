import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speezy_mobile/rolegame/data/datasources/role_local_data_source.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/params/params.dart';
import '../models/answer_model.dart';

abstract class AnswerRemoteDataSource {
  Future<AnswerModel> getAnswer({required RoleAnswerParams answerParams});
}

class AnswerRemoteDataSourceImpl implements AnswerRemoteDataSource {
  final Dio dio;




  AnswerRemoteDataSourceImpl({required this.dio});

  @override
  Future<AnswerModel> getAnswer({required RoleAnswerParams answerParams}) async {
    String prompt = "Aşağıda bir kullanıcı tarafından verilen İngilizce bir yanıt olacak. Bu yanıt, bir dil öğrenme uygulamasında görev bazlı konuşma pratiği sırasında verilmiştir. Yanıt: ${answerParams.answer} Lütfen sadece şu bilgileri ver: 1. Cümlede hata varsa sadece hatalı kelimeleri belirt. 2. Düzeltilmiş doğru tam cümleyi İngilizce olarak yaz. 3. Hata hakkında kısa bir açıklama yap (Türkçe). 4. 10 üzerinden puan ver. 5. Kısa motive edici bir cümle ekle. 6. Cümlede hata olup olmadığını belirten boolean bir değer ekle (true veya false). 7. Yazım kuralları açısından büyük harf ve küçük harf kullanımına bakma, sadece dilbilgisi ve kelime seçimine odaklan. Çıktıyı şu JSON formatında ver: {'feedback':{'has_mistake':true,'mistake':'...','correction':'...','explanation':'...','score':0,'encouragement':'...'}} Not: Eğer cümlede hata yoksa has_mistake alanı false olacak, 'mistake' alanına 'Yok', 'correction' alanına da 'Yok' yaz ve 'explanation' kısmına 'Cümlede hata bulunmuyor.' yaz.";


    Response? response;
    response = await dio.post(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyCvjoJ6E6fzChcZZIwsigRLEVzS9VTzKJ4',
      options: Options(headers: {
        'Content-Type': 'application/json',
      }),
      data: {
        "contents": [
          {
            "parts": [
              {"text": prompt}
            ]

          }
        ],
        "generationConfig": {
          "temperature": 0.9,
          "topK": 40,
          "topP": 0.9
        }

      },
    );

    if (response.statusCode == 200) {
      print(response.data);
      final answerText = response.data['candidates'][0]['content']['parts'][0]['text'];
      final cleanText = answerText.replaceAll('```json', '').replaceAll('```', '').trim();
      print("veri tipi ${answerText.runtimeType}");
      print(answerText);

      print(answerText);
      var roleJson =jsonDecode(cleanText);
      print("remote data ---$roleJson");


      return AnswerModel.fromJson(json: roleJson['feedback']);

    } else {
      print("deneme");
      throw ServerException();
    }


  }



}
