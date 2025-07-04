import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/AnswerEntity.dart';


abstract class AnswerRepository {
  Future<Either<Failure, AnswerEntity>> getAnswer({
    required  RoleAnswerParams answerParams,
  });
}
