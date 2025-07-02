import '../../../../../core/constants/constants.dart';
import '../../business/entities/RoleEntity.dart';

class RoleModel extends RoleEntity {
  const RoleModel({
    required String senorio,
    required String title,
    required String your_task,
    required Map<String,String> translations,
    required String title_emoji,
    required String role_emoji
  }) : super(
          senorio: senorio,
          title: title,
          your_task: your_task,
          translations: translations,
          title_emoji :title_emoji,
          role_emoji : role_emoji,




        );

  factory RoleModel.fromJson({required Map<String, dynamic> json}) {

    if (json == null) {

      throw Exception("RoleModel.fromJson: JSON data is null");

    }


    return RoleModel(

      title: json['title'] ?? '',
      senorio: json['scenario'] ?? '',
      your_task: json['your Task'] ?? '',
      translations: Map<String, String>.from(json['translations']) ?? {},
      title_emoji: json['titleemoji'] ?? "emoji bulunamadı",
      role_emoji: json['roleemoji'] ??  "emoji bulunamadı "
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title' :title,
      'scenario' :senorio,
      'your_task' :your_task,
      'translations' : translations,
      'titleemoji' :title_emoji,
      'roleemoji' :role_emoji


    };
  }
}
