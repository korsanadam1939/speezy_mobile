import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../business/repositories/ReadingRepository.dart';
import '../datasources/reading_local_data_source.dart';
import '../datasources/reading_remote_data_source.dart';
import '../models/reading_model.dart';

class ReadingRepositoryImpl implements ReadingRepository {
  final ReadingRemoteDataSource remoteDataSource;
  final ReadingLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  ReadingRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, ReadingModel>> getStory(
      {required ReadingParams readingParams}) async {
    if (await networkInfo.isConnected!) {
      print("internet var");
      try {
        ReadingModel remoteStory =
            await remoteDataSource.getStory(readingParams: readingParams);
        //print(remoteStory.words);

        await localDataSource.cacheStory(storyToCache: remoteStory);

        return Right(remoteStory);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {
      print("internet yok");
      try {
        ReadingModel localReading = await localDataSource.getLastStory();
        return Right(localReading);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a cache exception'));
      }
    }
  }
}
