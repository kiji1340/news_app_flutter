import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

import '../../../../../domain/models/article.dart';
import '../../../../../domain/models/source.dart';
import '../../../../../utils/constants/strings.dart';

@Entity(tableName: articleTableName)
class ArticleEntity extends Equatable {
  final int? id;
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  @PrimaryKey()
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

//<editor-fold desc="Data Methods">
  const ArticleEntity({
    this.id,
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  @override
  String toString() {
    return 'ArticleEntity{' +
        ' id: $id,' +
        ' source: $source,' +
        ' author: $author,' +
        ' title: $title,' +
        ' description: $description,' +
        ' url: $url,' +
        ' urlToImage: $urlToImage,' +
        ' publishedAt: $publishedAt,' +
        ' content: $content,' +
        '}';
  }

  Article toArticle() {
    return Article(
      id: id,
      source: source,
      author: author,
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage,
      publishedAt: publishedAt,
      content: content,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'source': this.source,
      'author': this.author,
      'title': this.title,
      'description': this.description,
      'url': this.url,
      'urlToImage': this.urlToImage,
      'publishedAt': this.publishedAt,
      'content': this.content,
    };
  }

  factory ArticleEntity.fromMap(Map<String, dynamic> map) {
    return ArticleEntity(
      id: map['id'] != null ? map['id'] as int : null,
      source: map['source'] != null
          ? map['source']
          : null,
      author: map['author'] != null ? map['author'] as String : null,
      title: map['title'] != null ? map['title'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
      url: map['url'] != null ? map['url'] as String : null,
      urlToImage:
          map['urlToImage'] != null ? map['urlToImage'] as String : null,
      publishedAt: map['publishAt'] != null ? map['publishAt'] as String : null,
      content: map['content'] != null ? map['content'] as String : null,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      source,
      author,
      title,
      description,
      url,
      urlToImage,
      publishedAt,
      content,
    ];
  }

//</editor-fold>
}
