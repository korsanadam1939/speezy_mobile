import '../../../../../core/constants/constants.dart';
import '../../business/entities/ReadingEntity.dart';

class ReadingModel extends ReadingEntity {
  const ReadingModel({
    required String story,
  }) : super(
          story: story,
        );

  factory ReadingModel.fromJson({required Map<String, dynamic> json}) {
    return ReadingModel(
      story: json['story'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      story : story,
    };
  }
}
