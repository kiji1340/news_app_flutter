import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../config/app_router.dart';
import '../../data/repositories/article_local_repository_impl.dart';
import '../../domain/models/article.dart';
import '../../domain/repositories/article_local_repository.dart';
import '../../injector.dart';
import '../cubits/local_articles/local_articles_cubit.dart';
import '../widgets/article_widget.dart';
import '../widgets/my_appbar_widget.dart';

@RoutePage()
class SaveArticlesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LocalArticlesCubit(injector<ArticleLocalRepository>())
            ..getLocalArticles(),
      child: _SaveArticleView(),
    );
  }
}

class _SaveArticleView extends HookWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        titleBar: "Saved Article",
      ),
      body: BlocBuilder<LocalArticlesCubit, LocalArticlesState>(
        builder: (_, state) {
          switch (state.runtimeType) {
            case LocalArticlesLoading:
              {
                return const Center(child: CupertinoActivityIndicator());
              }
            case LocalArticlesSuccess:
              {
                return _buildArticleList(state.articles);
              }
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildArticleList(List<Article> articles) {
    if (articles.isEmpty) {
      return const Center(
        child: Text(
          "No Saved Articles",
          style: TextStyle(color: Colors.black),
        ),
      );
    }

    return ListView.builder(
        itemCount: articles.length,
        itemBuilder: (context, index) {
          return ArticleWidget(
            article: articles[index],
            onRemove: (article) => {
              BlocProvider.of<LocalArticlesCubit>(context)
                  .removeArticle(article: article),
            },
            isRemovable: true,
            onArticlePressed: (article) => {
              appRouter.push(ArticleDetailRoute(article: article)),
            },
          );
        });
  }
}
