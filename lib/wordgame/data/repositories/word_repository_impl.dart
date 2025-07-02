import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../business/repositories/wordRepository.dart';
import '../datasources/word_local_data_source.dart';
import '../datasources/word_remote_data_source.dart';
import '../models/word_model.dart';

class WordRepositoryImpl implements WordRepository {
  final WordRemoteDataSource remoteDataSource;
  final WordLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  WordRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, WordModel>> getWord(
      {required WordParams wordParams}) async {
    if (await networkInfo.isConnected!) {
      print("internet var");
      try {
        WordModel remoteWord =
            await remoteDataSource.getWord(wordParams: wordParams);
        //print(remoteStory.words);

        localDataSource.cacheWord(wordToCache: remoteWord);

        return Right(remoteWord);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      print("internet yok");
      try {
        WordModel localWord = await localDataSource.getLastWord();
        return Right(localWord);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a cache exception'));
      }
    }
  }
}
