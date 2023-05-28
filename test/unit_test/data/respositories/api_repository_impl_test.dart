import 'dart:io';

import 'package:clean_architecture_flutter/src/data/datasources/remote/news_api.dart';
import 'package:clean_architecture_flutter/src/data/repositories/api_repository_impl.dart';
import 'package:clean_architecture_flutter/src/domain/models/requests/breaking_news_request.dart';
import 'package:clean_architecture_flutter/src/domain/models/responses/breaking_news_response.dart';
import 'package:clean_architecture_flutter/src/domain/repositories/api_repository.dart';
import 'package:clean_architecture_flutter/src/utils/resources/data_state.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:retrofit/retrofit.dart';

import 'api_repository_impl_test.mocks.dart';

@GenerateMocks([
  BreakingNewsResponse,
])
@GenerateNiceMocks([MockSpec<NewsApi>()])
void main() {
  late NewsApi api;
  late ApiRepositoryImpl apiRepositoryImpl;
  late BreakingNewsRequest request;
  late BreakingNewsResponse response;
  late ApiRepository apiRepository;

  group("Test api repository implement", () {
    setUp(() {
      api = MockNewsApi();
      apiRepositoryImpl = ApiRepositoryImpl(api);
      apiRepository = apiRepositoryImpl;
      request = const BreakingNewsRequest();
      response = MockBreakingNewsResponse();
    });

    test("Test apiRepository calls getBreakingNewsArticles response success", () async {
      when(api.getBreakingNewsArticles(
        apiKey: request.apiKey,
        country: request.country,
        category: request.category,
        page: request.page,
        pageSize: request.pageSize,
      )).thenAnswer((_) async => HttpResponse<BreakingNewsResponse>(
          response,
          Response(
            data: 'response json',
            statusCode: HttpStatus.ok,
            requestOptions: RequestOptions(path: ''),
          )));
      final result =
          await apiRepository.getBreakingNewsArticles(request: request);
      expect(result, isInstanceOf<DataSuccess>());
    });

    test("Test apiRepository calls getBreakingNewsArticles response error", () async {
      when(api.getBreakingNewsArticles(
        apiKey: request.apiKey,
        country: request.country,
        category: request.category,
        page: request.page,
        pageSize: request.pageSize,
      )).thenAnswer((_) async => HttpResponse<BreakingNewsResponse>(
          response,
          Response(
            data: 'response json',
            statusCode: HttpStatus.unauthorized,
            requestOptions: RequestOptions(path: ''),
          )));
      final result =
      await apiRepositoryImpl.getBreakingNewsArticles(request: request);
      expect(result, isInstanceOf<DataFailed>());
    });

    test("Test apiRepository calls getBreakingNewsArticles Fail", () async {
      when(api.getBreakingNewsArticles(
        apiKey: request.apiKey,
        country: request.country,
        category: request.category,
        page: request.page,
        pageSize: request.pageSize,
      )).thenThrow(
        DioError(
          response: Response(
            data: 'Something went wrong',
            statusCode: HttpStatus.notFound,
            requestOptions: RequestOptions(path: ''),
          ),
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final result = await apiRepositoryImpl.getBreakingNewsArticles(request: request);
      expect(result, isInstanceOf<DataFailed>());
    });
  });
}
