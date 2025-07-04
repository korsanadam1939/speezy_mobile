import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speezy_mobile/rolegame/data/datasources/role_local_data_source.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/params/params.dart';
import '../models/role_model.dart';

abstract class RoleRemoteDataSource {
  Future<RoleModel> getRole({required RoleParams roleParams});
}

class RoleRemoteDataSourceImpl implements RoleRemoteDataSource {
  final Dio dio;


  RoleRemoteDataSourceImpl({required this.dio});

  @override
  Future<RoleModel> getRole({required RoleParams roleParams}) async {
    String? senorio = await getLastStory();
    print("senoryo");
    print(senorio);

    int randomNumber = Random().nextInt(1000000);
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
              {"text": '$senorio bunla aynı olmasın bu konudan çok farklı ilginç aşırı farklı olsun,İngilizce öğrenen kullanıcılar için gerçekçi ve yaratıcı rol yapma görevleri üretmeni istiyorum. Kurallar şunlardır: Tüm görevler sadece İngilizce olacak. Kullanıcının seviyesi A1 arasındadır. Her görev, gerçek hayatta karşılaşılabilecek bir senaryo sunmalı (örneğin: havalimanı, restoran, market, otel, toplu taşıma, vb.). Her görevde, kullanıcının İngilizce konuşarak çözmesi gereken bir problem veya iletişim durumu olmalı. Görev sonunda, kullanıcının ne yapması gerektiğini açıklayan bir hedef cümlesi ekle ("Durumu açıklamaya çalış", "Yardım iste", "Sipariş ver", vb.). Her görev ortalama 3–5 cümlelik bir sahne tanımı içermeli. Aşağıdaki formatta bir görev üret (json verilecek ve sadece bir tane): title (İngilizce) scenario: (İngilizce sahne anlatımı) your Task: (Kullanıcının görevi, İngilizce olarak) translations scenario da geçen tüm kelimeler örnek : "translations": { I/flutter ( 4912): "the": "el", I/flutter ( 4912): "senorial": "señorial", I/flutter ( 4912): "crest": "escudo", I/flutter ( 4912): "on": "en", I/flutter ( 4912): "edict": "edicto", I/flutter ( 4912): "did": "hizo", I/flutter ( 4912): "nothing": "nada", I/flutter ( 4912): "to": "a", I/flutter ( 4912): "impress": "impresionar", I/flutter ( 4912): "isabella": "isabela", I/flutter ( 4912): "a": "un", I/flutter ( 4912): "profound": "profundo", I/flutter ( 4912): "emptiness": "vacío", I/flutter ( 4912): "resonated": "resonó" ,titleemoji : role e uygun emoji , roleemoji : role de kullanılan kişiye özel emoji'}
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
      final roleText = response.data['candidates'][0]['content']['parts'][0]['text'];
      final cleanText = roleText.replaceAll('```json', '').replaceAll('```', '').trim();
      print("veri tipi ${roleText.runtimeType}");
      print(roleText);

      print(roleText);
      var roleJson =jsonDecode(cleanText);
      print("remote data ---$roleJson");


      return RoleModel.fromJson(json: roleJson);

    } else {
      print("deneme");
      throw ServerException();
    }


  }

  Future<String?> getLastStory() async{

    var localDataSource = RoleLocalDataSourceImpl(sharedPreferences: await SharedPreferences.getInstance(),);
    RoleModel? role = await localDataSource?.getLastRole();



    print("laststory");
    print(role?.senorio);
    return role?.senorio;


}
}
