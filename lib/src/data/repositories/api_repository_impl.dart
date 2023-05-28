import '../../domain/models/requests/breaking_news_request.dart';
import '../../domain/models/responses/breaking_news_response.dart';
import '../../domain/repositories/api_repository.dart';
import '../../utils/resources/data_state.dart';
import '../../domain/repositories/base/base_api_repository.dart';
import '../datasources/remote/news_api.dart';

class ApiRepositoryImpl extends BaseApiRepository
    implements ApiRepository {
  final NewsApi _api;

  ApiRepositoryImpl(this._api);

  @override
  Future<DataState<BreakingNewsResponse>> getBreakingNewsArticles(
      {required BreakingNewsRequest request}) {
    return getStateOf<BreakingNewsResponse>(
      request: () => _api.getBreakingNewsArticles(
        apiKey: request.apiKey,
        country: request.country,
        category: request.category,
        page: request.page,
        pageSize: request.pageSize,
      ),
    );
  }
}
