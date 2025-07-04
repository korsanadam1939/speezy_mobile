import 'package:dartz/dartz.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../business/repositories/RoleRepository.dart';
import '../datasources/role_local_data_source.dart';
import '../datasources/role_remote_data_source.dart';
import '../models/role_model.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
class RoleRepositoryImpl implements RoleRepository {
  final RoleRemoteDataSource remoteDataSource;
  final RoleLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  RoleRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, RoleModel>> getRole(
      {required RoleParams roleParams}) async {
    if (await networkInfo.isConnected!) {
      print("internet var");
      try {
        RoleModel remoteRole =
            await remoteDataSource.getRole(roleParams: roleParams);
        //print(remoteStory.words);

        localDataSource.cacheRole(roleToCache: remoteRole);

        return Right(remoteRole);
      } on ServerException {
        return Left(ServerFailure(errorMessage: 'This is a server exception'));
      }
    } else {


      print("internet yok");
      try {
        RoleModel localRole = await localDataSource.getLastRole();
        return Right(localRole);
      } on CacheException {
        return Left(CacheFailure(errorMessage: 'This is a cache exception'));
      }
    }
  }


}
