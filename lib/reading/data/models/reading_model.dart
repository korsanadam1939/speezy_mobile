import '../../../../../core/constants/constants.dart';
import '../../business/entities/ReadingEntity.dart';

class ReadingModel extends ReadingEntity {
  const ReadingModel({
    required String story,
    required String title,
  }) : super(
          story: story,
          title: title,


        );

  factory ReadingModel.fromJson({required Map<String, dynamic> json}) {
    return ReadingModel(
      story: json['story'],
      title: json['title']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'story' : story,
      'title' : title,
    };
  }
}
