import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../business/repositories/AnswerRepository.dart';
import '../datasources/answer_local_data_source.dart';
import '../datasources/answer_remote_data_source.dart';
import '../models/answer_model.dart';

class AnswerRepositoryImpl implements AnswerRepository {
  final AnswerRemoteDataSource remoteDataSource;
  final AnswerLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  AnswerRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, AnswerModel>> getAnswer(
      {required RoleAnswerParams answerParams}) async {
    if (await networkInfo.isConnected!) {
      print("internet var");
      try {
        AnswerModel remoteAnswer =
            await remoteDataSource.getAnswer(answerParams: answerParams);


        localDataSource.cacheAnswer(answerToCache: remoteAnswer);

        return Right(remoteAnswer);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      print("internet yok");
      try {
        AnswerModel localAnswer = await localDataSource.getLastAnswer();
        return Right(localAnswer);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a cache exception'));
      }
    }
  }


}
