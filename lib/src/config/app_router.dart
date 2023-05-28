import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../domain/models/article.dart';
import '../presentation/views/article_details_page.dart';
import '../presentation/views/breaking_news_page.dart';
import '../presentation/views/save_articles_page.dart';
import '../presentation/views/splash_screen_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();
  @override
  final List<AutoRoute> routes = [
    AutoRoute(page: BreakingNewsRoute.page, path: '/'),
    AutoRoute(page: ArticleDetailRoute.page),
    AutoRoute(page: SaveArticlesRoute.page),
  ];
}

final appRouter = AppRouter();
