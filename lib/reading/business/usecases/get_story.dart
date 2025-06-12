import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/ReadingEntity.dart';
import '../repositories/ReadingRepository.dart';

class GetStory {
  final ReadingRepository readingRepository;

  GetStory({required this.readingRepository});

  Future<Either<Failure, ReadingEntity>> call({
    required ReadingParams readingParams,
  }) async {
    return await readingRepository.getStory(readingParams: readingParams);
  }
}
