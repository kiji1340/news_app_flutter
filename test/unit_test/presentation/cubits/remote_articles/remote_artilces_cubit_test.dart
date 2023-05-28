
import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:clean_architecture_flutter/src/domain/models/requests/breaking_news_request.dart';
import 'package:clean_architecture_flutter/src/domain/models/responses/breaking_news_response.dart';
import 'package:clean_architecture_flutter/src/domain/repositories/api_repository.dart';
import 'package:clean_architecture_flutter/src/presentation/cubits/remote_articles/remote_articles_cubit.dart';
import 'package:clean_architecture_flutter/src/utils/resources/data_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../domain/responses/breaking_news_response_test.dart';
import 'remote_artilces_cubit_test.mocks.dart';

@GenerateNiceMocks([MockSpec<ApiRepository>()])
void main() {
  late ApiRepository apiRepository;
  late RemoteArticlesCubit cubit;
  late BreakingNewsRequest request;
  late BreakingNewsResponse response;

  group("Test remote articles cubit", () {
    setUp(() {
      apiRepository = MockApiRepository();
      request = const BreakingNewsRequest();
      response = MockBreakingNewsResponse().mockData();
    });

    blocTest<RemoteArticlesCubit, RemoteArticlesState>(
      "Test RemoteArticlesCubit success",
      setUp: () {
        when(apiRepository.getBreakingNewsArticles(request: request))
            .thenAnswer((_) => Future.value(DataSuccess(response)));
        cubit = RemoteArticlesCubit(apiRepository);
      },
      build: () {
        return cubit;
      },
      act: (cubit) async {
        cubit.getBreakingNewsArticles(request: request);
      },
      expect: () => [isInstanceOf<RemoteArticlesSuccess>()],
    );

    blocTest("Test RemoteArticlesCubit fail",
        setUp: () {
          when(apiRepository.getBreakingNewsArticles(request: request))
              .thenAnswer(
            (_) => Future.value(
              DataFailed(DioError(requestOptions: RequestOptions(),)),
            ),
          );
          cubit = RemoteArticlesCubit(apiRepository);
        },
        build: () => cubit,
        act: (cubit) => cubit.getBreakingNewsArticles(),
        expect: () => [isInstanceOf<RemoteArticlesFailed>()]);
  });
}
