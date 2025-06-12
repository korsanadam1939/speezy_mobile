import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../business/entities/ReadingEntity.dart';
import '../../business/usecases/get_story.dart';
import '../../data/datasources/reading_local_data_source.dart';
import '../../data/datasources/reading_remote_data_source.dart';
import '../../data/repositories/reading_repository_impl.dart';

class ReadingProvider extends ChangeNotifier {
  ReadingEntity? story;
  Failure? failure;

  ReadingProvider({
    this.story,
    this.failure,
  });

  void eitherFailureOrStory() async {
    ReadingRepositoryImpl repository = ReadingRepositoryImpl(
      remoteDataSource: ReadingRemoteDataSourceImpl(
        dio: Dio(),
      ),
      localDataSource: ReadingLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),

      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrStory = await GetStory(readingRepository: repository).call(
      readingParams: ReadingParams(story?.story ?? "hikaye yok"),
    );

    failureOrStory.fold(
      (Failure newFailure) {
        story = null;
        failure = newFailure;
        notifyListeners();
      },
      (ReadingEntity newStory) {
        story = newStory;
        failure = null;
        notifyListeners();
      },
    );
  }
}
