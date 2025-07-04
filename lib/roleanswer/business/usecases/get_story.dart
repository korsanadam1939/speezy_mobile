import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/AnswerEntity.dart';
import '../repositories/AnswerRepository.dart';

class GetAnswer {
  final AnswerRepository roleRepository;

  GetAnswer({required this.roleRepository});

  Future<Either<Failure, AnswerEntity>> call({
    required RoleAnswerParams answerParams,
  }) async {
    return await roleRepository.getAnswer(answerParams: answerParams);
  }
}
