import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/models/article.dart';
import '../../../domain/models/requests/breaking_news_request.dart';
import '../../../domain/repositories/api_repository.dart';
import '../../../utils/constants/numbers.dart';
import '../../../utils/resources/data_state.dart';
import '../base/base_cubit.dart';

part 'remote_articles_state.dart';

class RemoteArticlesCubit
    extends BaseCubit<RemoteArticlesState, List<Article>> {
  RemoteArticlesCubit(this._apiRepository)
      : super(const RemoteArticlesLoading(), []);

  final ApiRepository _apiRepository;

  int _page = 1;
  BreakingNewsRequest _request = const BreakingNewsRequest();

  Future<void> getBreakingNewsArticles({BreakingNewsRequest? request}) async {
    if (isBusy) return;
    if (request != null) {
      _request = request;
    }

    if (_request.page != _page) {
      return;
    }

    await run(() async {
      final response = await _apiRepository.getBreakingNewsArticles(
        request: _request,
      );

      if (response is DataSuccess) {
        final articles = response.data!.articles;
        final noMoreData = articles.length < defaultPageSize;

        data.addAll(articles);
        _page++;
        if (!noMoreData) {
          _request = BreakingNewsRequest(page: _page);
        }

        emit(RemoteArticlesSuccess(articles: data, noMoreData: noMoreData));
      } else if (response is DataFailed) {
        emit(RemoteArticlesFailed(error: response.error));
      }
    });
  }
}
