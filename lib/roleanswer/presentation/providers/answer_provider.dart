import 'package:data_connection_checker_tv/data_connection_checker.dart';

import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/connection/network_info.dart';
import '../../../../../core/errors/failure.dart';
import '../../../../../core/params/params.dart';
import '../../business/entities/AnswerEntity.dart';
import '../../business/usecases/get_story.dart';
import '../../data/datasources/answer_local_data_source.dart';
import '../../data/datasources/answer_remote_data_source.dart';
import '../../data/repositories/answer_repository_impl.dart';

class AnswerProvider extends ChangeNotifier {
  AnswerEntity? answer;
  Failure? failure;

  AnswerProvider({
    this.answer,
    this.failure,
  });

  void eitherFailureOrAnswer(String sentence) async {

    answer = null;
    notifyListeners();

    AnswerRepositoryImpl repository = AnswerRepositoryImpl(
      remoteDataSource: AnswerRemoteDataSourceImpl(
        dio: Dio(),
      ),
      localDataSource: AnswerLocalDataSourceImpl(
        sharedPreferences: await SharedPreferences.getInstance(),

      ),
      networkInfo: NetworkInfoImpl(
        DataConnectionChecker(),
      ),
    );

    final failureOrAnswer = await GetAnswer(roleRepository: repository).call(
      answerParams: RoleAnswerParams(sentence)
    );

    failureOrAnswer.fold(
      (Failure newFailure) {
        answer = null;
        failure = newFailure;
        notifyListeners();
      },
      (AnswerEntity newAnswer) {
        answer = newAnswer;
        failure = null;
        notifyListeners();
      },
    );
  }
}
