import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/RoleEntity.dart';
import '../repositories/RoleRepository.dart';

class GetRole {
  final RoleRepository roleRepository;

  GetRole({required this.roleRepository});

  Future<Either<Failure, RoleEntity>> call({
    required RoleParams roleParams,
  }) async {
    return await roleRepository.getRole(roleParams: roleParams);
  }
}
