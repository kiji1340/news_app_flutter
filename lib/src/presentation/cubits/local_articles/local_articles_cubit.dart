import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../domain/models/article.dart';
import '../../../domain/repositories/article_local_repository.dart';

part 'local_articles_state.dart';

class LocalArticlesCubit extends Cubit<LocalArticlesState> {
  final ArticleLocalRepository _articleLocalRepository;

  LocalArticlesCubit(this._articleLocalRepository)
      : super(const LocalArticlesLoading());

  Future<void> getLocalArticles() async {
    emit(const LocalArticlesLoading());
    emit(await _getLocalArticles());
  }

  Future<void> removeArticle({required Article article}) async {
    emit(const LocalArticlesLoading());
    await _articleLocalRepository.removeData(article);
    emit(await _getLocalArticles());
  }

  Future<void> saveArticle({required Article article}) async {
    emit(const LocalArticlesLoading());
    await _articleLocalRepository.saveData(article);
    emit(await _getLocalArticles());
  }

  Future<LocalArticlesState> _getLocalArticles() async {
    final articles = await _articleLocalRepository.getSavedArticles();
    return LocalArticlesSuccess(articles: articles);
  }
}
