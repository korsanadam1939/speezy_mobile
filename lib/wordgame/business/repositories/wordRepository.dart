import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/wordEntity.dart';


abstract class WordRepository {
  Future<Either<Failure, Wordentity>> getWord({
    required WordParams wordParams,
  });
}
