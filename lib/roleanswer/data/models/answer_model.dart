import '../../../../../core/constants/constants.dart';
import '../../business/entities/AnswerEntity.dart';

class AnswerModel extends AnswerEntity {
  const AnswerModel({
    required String mistake,
    required String correction,
    required String explanation,
    required int score,
    required String encouragement,
    required bool has_mistake_boolean,
  }) : super(
          mistake: mistake,
          correction: correction,
          explanation: explanation,
          score: score,
          encouragement: encouragement,
          has_mistake_boolean: has_mistake_boolean


        );

  factory AnswerModel.fromJson({required Map<String, dynamic> json}) {

    if (json == null) {

      throw Exception("AnswerModel.fromJson: JSON data is null");

    }


    return AnswerModel(

      mistake: json['mistake'],
      correction: json['correction'],
      explanation: json['explanation'],
      score: json['score'],
      encouragement: json['encouragement'],
      has_mistake_boolean: json['has_mistake']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mistake' :mistake,
      'correction' : correction,
      'explanation' :explanation,
      'score' : score,
      'encouragement' : encouragement,
      'has_mistake' : has_mistake_boolean







    };
  }
}
