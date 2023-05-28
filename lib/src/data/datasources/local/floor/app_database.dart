import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
import 'converters/source_type_converter.dart';
import 'daos/article_dao.dart';
import 'entities/article_entity.dart';


part 'app_database.g.dart';

@TypeConverters([SourceTypeConverter])
@Database(version: 1, entities: [ArticleEntity])
abstract class AppDatabase extends FloorDatabase{
  ArticleDao get articleDao;
}