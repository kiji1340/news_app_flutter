import 'package:equatable/equatable.dart';

import '../article.dart';

class BreakingNewsResponse extends Equatable{
  final String status;
  final int totalResults;
  final List<Article> articles;

//<editor-fold desc="Data Methods">
  const BreakingNewsResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is BreakingNewsResponse &&
          runtimeType == other.runtimeType &&
          status == other.status &&
          totalResults == other.totalResults &&
          articles == other.articles);

  @override
  int get hashCode =>
      status.hashCode ^ totalResults.hashCode ^ articles.hashCode;

  @override
  String toString() {
    return 'BreakingNewsResponse{' +
        ' status: $status,' +
        ' totalResults: $totalResults,' +
        ' articles: $articles,' +
        '}';
  }

  BreakingNewsResponse copyWith({
    String? status,
    int? totalResults,
    List<Article>? articles,
  }) {
    return BreakingNewsResponse(
      status: status ?? this.status,
      totalResults: totalResults ?? this.totalResults,
      articles: articles ?? this.articles,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': this.status,
      'totalResults': this.totalResults,
      'articles': this.articles,
    };
  }

  factory BreakingNewsResponse.fromMap(Map<String, dynamic> map) {
    return BreakingNewsResponse(
      status: map['status'] as String,
      totalResults: map['totalResults'] as int,
      articles: List<Article>.from(
          (map['articles'] as List<dynamic>).map<Article>(
              (x) => Article.fromMap(x as Map<String, dynamic>)
          ),
      ),
    );
  }

  @override
  List<Object?> get props {
    return [
      status,
      totalResults,
      articles,
    ];
  }

//</editor-fold>
}