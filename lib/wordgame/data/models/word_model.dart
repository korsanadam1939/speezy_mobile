import '../../../../../core/constants/constants.dart';
import '../../business/entities/wordEntity.dart';

class WordModel extends Wordentity {
  const WordModel({
    required List<dynamic> words,

  }) : super(
      words: words,



        );

  factory WordModel.fromJson({required Map<String, dynamic> json}) {
    return WordModel(
      words: json['wordGroups'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'words' :words
    };
  }
}
