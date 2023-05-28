import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'data/datasources/local/floor/app_database.dart';
import 'data/datasources/remote/news_api.dart';
import 'data/repositories/api_repository_impl.dart';
import 'data/repositories/article_local_repository_impl.dart';
import 'domain/repositories/api_repository.dart';
import 'domain/repositories/article_local_repository.dart';
import 'utils/constants/strings.dart';


final injector = GetIt.instance;

Future<void> initializeDependencies() async {
  final dio = Dio();
  dio.interceptors.add(AwesomeDioInterceptor());

  injector.registerSingleton<Dio>(dio);

  injector.registerSingleton<NewsApi>(NewsApi(injector<Dio>()));

  injector.registerSingleton<ApiRepository>(
    ApiRepositoryImpl(injector<NewsApi>())
  );

  final db = await $FloorAppDatabase.databaseBuilder(databaseName).build();
  injector.registerSingleton(db);

  injector.registerSingleton(
    ArticleLocalRepositoryImpl(injector<AppDatabase>()),
  );

  injector.registerSingleton<ArticleLocalRepository>(
    ArticleLocalRepositoryImpl(db),
  );
}