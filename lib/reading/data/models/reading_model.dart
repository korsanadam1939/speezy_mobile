import '../../../../../core/constants/constants.dart';
import '../../business/entities/ReadingEntity.dart';

class ReadingModel extends ReadingEntity {
  const ReadingModel({
    required String story,
    required String title,
    required Map<String,String> translations,
  }) : super(
          story: story,
          title: title,
          translations: translations,


        );

  factory ReadingModel.fromJson({required Map<String, dynamic> json}) {
    return ReadingModel(
      story: json['story'],
      title: json['title'],
      translations: Map<String, String>.from(json['translations']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'story' : story,
      'title' : title,
      'translations' : translations
    };
  }
}
