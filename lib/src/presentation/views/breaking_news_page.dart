import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../config/app_router.dart';
import '../../domain/models/article.dart';
import '../../domain/models/requests/breaking_news_request.dart';
import '../../domain/repositories/api_repository.dart';
import '../../injector.dart';
import '../../utils/extensions/scroll_controller.dart';
import '../cubits/remote_articles/remote_articles_cubit.dart';
import '../widgets/article_widget.dart';

@RoutePage()
class BreakingNewsPage extends StatelessWidget {
  const BreakingNewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => RemoteArticlesCubit(injector<ApiRepository>())
          ..getBreakingNewsArticles(),
        child: _BreakingNewsView());
  }
}


class _BreakingNewsView extends HookWidget {

  @override
  Widget build(BuildContext context) {
    final remoteArticlesCubit = BlocProvider.of<RemoteArticlesCubit>(context);
    final scrollController = useScrollController();

    useEffect(() {
      scrollController.onScrollEndListener(() {
        remoteArticlesCubit.getBreakingNewsArticles();
      });

      return scrollController.dispose;
    }, const []);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daily News",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          GestureDetector(
            onTap: () => appRouter.push(const SaveArticlesRoute()),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Icon(
                Icons.bookmark,
                color: Colors.black,
              ),
            ),
          )
        ],
      ),
      body: BlocBuilder<RemoteArticlesCubit, RemoteArticlesState>(
        builder: (_, state) {
          switch (state.runtimeType) {
            case RemoteArticlesLoading:
              return const Center(child: CupertinoActivityIndicator());
            case RemoteArticlesSuccess:
              return _buildArticles(
                  scrollController, state.articles, state.noMoreData);

            case RemoteArticlesFailed:
              return const Center(child: Icon(Icons.refresh));
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  Widget _buildArticles(
    ScrollController scrollController,
    List<Article> articles,
    bool noMoreData,
  ) {
    return CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverList(
            delegate: SliverChildBuilderDelegate(
          (context, index) => ArticleWidget(
            article: articles[index],
            onArticlePressed: (article) {
              appRouter.push(ArticleDetailRoute(article: article));
            },
          ),
          childCount: articles.length,
        )),
        if (!noMoreData)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 14, bottom: 32),
              child: CupertinoActivityIndicator(),
            ),
          ),
      ],
    );
  }
}
