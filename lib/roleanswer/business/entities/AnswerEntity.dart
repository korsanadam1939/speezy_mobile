class AnswerEntity {
  final String mistake;
  final String correction;
  final String explanation;
  final int score;
  final String encouragement;
  final bool has_mistake_boolean;

  const AnswerEntity({ required this.mistake, required this.correction, required this.explanation,
      required this.score, required this.encouragement,required this.has_mistake_boolean});




}
