import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/RoleEntity.dart';


abstract class RoleRepository {
  Future<Either<Failure, RoleEntity>> getRole({
    required RoleParams roleParams,
  });
}
