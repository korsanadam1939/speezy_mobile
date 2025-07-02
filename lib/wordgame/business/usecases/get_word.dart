import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../entities/wordEntity.dart';
import '../repositories/wordRepository.dart';

class GetWord {
  final WordRepository wordRepository;

  GetWord({required this.wordRepository});

  Future<Either<Failure, Wordentity>> call({
    required WordParams wordParams,
  }) async {
    return await wordRepository.getWord(wordParams: wordParams);
  }
}
