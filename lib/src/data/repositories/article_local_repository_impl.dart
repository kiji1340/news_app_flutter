import '../../domain/models/article.dart';
import '../../domain/repositories/article_local_repository.dart';
import '../datasources/local/floor/entities/article_entity.dart';
import '../../domain/repositories/base/base_database_repository.dart';

class ArticleLocalRepositoryImpl extends BaseDatabaseRepository
    implements ArticleLocalRepository {
  ArticleLocalRepositoryImpl(super.appDatabase);

  @override
  Future<List<Article>> getSavedArticles() async {
    List<ArticleEntity> list = await appDatabase.articleDao.getArticles();
    List<Article> listResult = list.map((e) => e.toArticle()).toList();
    return listResult;
  }

  @override
  Future<void>? removeData(Article data) {
    if (data.url != null) {
      return appDatabase.articleDao.removeById(data.url!);
    }
    return null;
  }

  @override
  Future<void> saveData(Article data) {
    return appDatabase.articleDao.insert(ArticleEntity.fromMap(data.toMap()));
  }
}
