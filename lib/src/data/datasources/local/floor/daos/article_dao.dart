import 'package:floor/floor.dart';

import '../../../../../utils/constants/strings.dart';
import '../entities/article_entity.dart';

@dao
abstract class ArticleDao{
  @Query('SELECT * FROM $articleTableName')
  Future<List<ArticleEntity>> getArticles();
  
  @Query('DELETE FROM $articleTableName WHERE url = :url')
  Future<void> removeById(String url);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(ArticleEntity article);

  @delete
  Future<void> remove(ArticleEntity article);
}