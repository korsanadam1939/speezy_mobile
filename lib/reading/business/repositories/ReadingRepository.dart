import 'package:dartz/dartz.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/ReadingEntity.dart';


abstract class ReadingRepository {
  Future<Either<Failure, ReadingEntity>> getStory({
    required ReadingParams readingParams,
  });
}
