import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../business/entities/wordEntity.dart';
import '../../business/usecases/get_word.dart';
import '../../data/datasources/word_local_data_source.dart';
import '../../data/datasources/word_remote_data_source.dart';
import '../../data/repositories/word_repository_impl.dart';

class WordProvider extends ChangeNotifier {
  Wordentity? words;
  Failure? failure;

  WordProvider({
    this.words,
    this.failure,
  });

  void eitherFailureOrWord() async {
    WordRepositoryImpl repository = WordRepositoryImpl(
      remoteDataSource: WordRemoteDataSourceImpl(
        dio: Dio(),
      ),
      localDataSource: WordLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),

      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrStory = await GetWord(wordRepository: repository).call(
      wordParams: WordParams(words?.words ?? [] )
    );

    failureOrStory.fold(
      (Failure newFailure) {
        words = null;
        failure = newFailure;
        notifyListeners();
      },
      (Wordentity newWord) {
        words = newWord;
        failure = null;
        notifyListeners();
      },
    );
  }
}
