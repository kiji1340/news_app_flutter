import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:oktoast/oktoast.dart';

import '../../domain/models/article.dart';
import '../../domain/repositories/article_local_repository.dart';
import '../../injector.dart';
import '../cubits/local_articles/local_articles_cubit.dart';
import '../widgets/my_appbar_widget.dart';

@RoutePage()
class ArticleDetailPage extends StatelessWidget {
  final Article article;

  const ArticleDetailPage({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocalArticlesCubit(injector<ArticleLocalRepository>()),
      child: _ArticleDetailView(
        article: article,
      ),
    );
  }
}

class _ArticleDetailView extends HookWidget {
  final Article article;

  const _ArticleDetailView({Key? key, required this.article}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localArticleCubit = BlocProvider.of<LocalArticlesCubit>(context);
    return Scaffold(
      appBar: MyAppBar(
        titleBar: "Detail",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildArticleTitleAndDate(),
            _buildArticleImage(),
            _buildArticleDescription(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          localArticleCubit.saveArticle(article: article);
          showToast('This article was saved');
        },
      ),
    );
  }

  Widget _buildArticleTitleAndDate() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            article.title ?? "",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
            ),
          ),
          const SizedBox(
            height: 14,
          ),
          Row(
            children: [
              const Icon(
                Icons.timer_outlined,
                size: 16,
              ),
              const SizedBox(
                width: 4,
              ),
              Text(
                article.publishedAt ?? "",
                style: const TextStyle(fontSize: 12),
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildArticleImage() {
    return Container(
      width: double.maxFinite,
      height: 250,
      margin: const EdgeInsets.only(top: 14),
      child: Image.network(
        article.urlToImage ?? "",
        fit: BoxFit.cover,
        alignment: Alignment.topCenter,
      ),
    );
  }

  Widget _buildArticleDescription() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 18,
      ),
      child: Text(
        "${article.description}\n\n${article.content}",
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
