import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../business/entities/RoleEntity.dart';
import '../../business/usecases/get_story.dart';
import '../../data/datasources/role_local_data_source.dart';
import '../../data/datasources/role_remote_data_source.dart';
import '../../data/repositories/role_repository_impl.dart';

class RoleProvider extends ChangeNotifier {
  RoleEntity? role;
  Failure? failure;

  RoleProvider({
    this.role,
    this.failure,
  });

  void eitherFailureOrRole() async {

    role = null;
    notifyListeners();

    RoleRepositoryImpl repository = RoleRepositoryImpl(
      remoteDataSource: RoleRemoteDataSourceImpl(
        dio: Dio(),
      ),
      localDataSource: RoleLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),

      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrRole = await GetRole(roleRepository: repository).call(
      roleParams: RoleParams(role?.senorio ?? "senori bulunamadı")
    );

    failureOrRole.fold(
      (Failure newFailure) {
        role = null;
        failure = newFailure;
        notifyListeners();
      },
      (RoleEntity newRole) {
        role = newRole;
        failure = null;
        notifyListeners();
      },
    );
  }
}
