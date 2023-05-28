import 'package:equatable/equatable.dart';

import '../models/source.dart';

class Article extends Equatable {
  final int? id;
  final Source? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

//<editor-fold desc="Data Methods">
  const Article({
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
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Article &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          source == other.source &&
          author == other.author &&
          title == other.title &&
          description == other.description &&
          url == other.url &&
          urlToImage == other.urlToImage &&
          publishedAt == other.publishedAt &&
          content == other.content);

  @override
  int get hashCode =>
      id.hashCode ^
      source.hashCode ^
      author.hashCode ^
      title.hashCode ^
      description.hashCode ^
      url.hashCode ^
      urlToImage.hashCode ^
      publishedAt.hashCode ^
      content.hashCode;

  @override
  String toString() {
    return 'Article{' +
        ' id: $id,' +
        ' source: $source,' +
        ' author: $author,' +
        ' title: $title,' +
        ' description: $description,' +
        ' url: $url,' +
        ' urlToImage: $urlToImage,' +
        ' publishAt: $publishedAt,' +
        ' content: $content,' +
        '}';
  }

  Article copyWith({
    int? id,
    Source? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishAt,
    String? content,
  }) {
    return Article(
      id: id ?? this.id,
      source: source ?? this.source,
      author: author ?? this.author,
      title: title ?? this.title,
      description: description ?? this.description,
      url: url ?? this.url,
      urlToImage: urlToImage ?? this.urlToImage,
      publishedAt: publishAt ?? this.publishedAt,
      content: content ?? this.content,
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
      'publishAt': this.publishedAt,
      'content': this.content,
    };
  }

  factory Article.fromMap(Map<String, dynamic> map) {
    return Article(
      id: map['id'] != null ? map['id'] as int : null,
      source: map['source'] != null
          ? Source.fromMap(map['source'] as Map<String, dynamic>)
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
