/// Standard result classes.
library;

import 'base_result.dart';

/// Text search result.
class TextResult extends BaseResult {
  TextResult({this.title = '', this.href = '', this.body = ''}) {
    title = normalizeField('title', title);
    href = normalizeField('href', href);
    body = normalizeField('body', body);
  }
  String title;
  String href;
  String body;

  @override
  Map<String, dynamic> toJson() => {
        'title': title,
        'href': href,
        'body': body,
      };
}

/// Image search result.
class ImagesResult extends BaseResult {
  ImagesResult({
    this.title = '',
    this.image = '',
    this.thumbnail = '',
    this.url = '',
    this.height = '',
    this.width = '',
    this.source = '',
  }) {
    title = normalizeField('title', title);
    image = normalizeField('image', image);
    thumbnail = normalizeField('thumbnail', thumbnail);
    url = normalizeField('url', url);
  }
  String title;
  String image;
  String thumbnail;
  String url;
  String height;
  String width;
  String source;

  @override
  Map<String, dynamic> toJson() => {
        'title': title,
        'image': image,
        'thumbnail': thumbnail,
        'url': url,
        'height': height,
        'width': width,
        'source': source,
      };
}

/// News search result.
class NewsResult extends BaseResult {
  NewsResult({
    this.date = '',
    this.title = '',
    this.body = '',
    this.url = '',
    this.image = '',
    this.source = '',
  }) {
    date = normalizeField('date', date);
    title = normalizeField('title', title);
    body = normalizeField('body', body);
    url = normalizeField('url', url);
    image = normalizeField('image', image);
  }
  String date;
  String title;
  String body;
  String url;
  String image;
  String source;

  @override
  Map<String, dynamic> toJson() => {
        'date': date,
        'title': title,
        'body': body,
        'url': url,
        'image': image,
        'source': source,
      };
}

/// Video search result.
class VideosResult extends BaseResult {
  VideosResult({
    this.title = '',
    this.content = '',
    this.description = '',
    this.duration = '',
    this.embedHtml = '',
    this.embedUrl = '',
    this.imageToken = '',
    Map<String, String>? images,
    this.provider = '',
    this.published = '',
    this.publisher = '',
    Map<String, String>? statistics,
    this.uploader = '',
  })  : images = images ?? {},
        statistics = statistics ?? {} {
    title = normalizeField('title', title);
    publisher = normalizeField('publisher', publisher);
  }
  String title;
  String content;
  String description;
  String duration;
  String embedHtml;
  String embedUrl;
  String imageToken;
  Map<String, String> images;
  String provider;
  String published;
  String publisher;
  Map<String, String> statistics;
  String uploader;

  @override
  Map<String, dynamic> toJson() => {
        'title': title,
        'content': content,
        'description': description,
        'duration': duration,
        'embed_html': embedHtml,
        'embed_url': embedUrl,
        'image_token': imageToken,
        'images': images,
        'provider': provider,
        'published': published,
        'publisher': publisher,
        'statistics': statistics,
        'uploader': uploader,
      };
}

/// Book search result.
class BooksResult extends BaseResult {
  BooksResult({
    this.title = '',
    this.author = '',
    this.publisher = '',
    this.info = '',
    this.url = '',
  }) {
    title = normalizeField('title', title);
    author = normalizeField('author', author);
    publisher = normalizeField('publisher', publisher);
    info = normalizeField('info', info);
    url = normalizeField('url', url);
  }
  String title;
  String author;
  String publisher;
  String info;
  String url;

  @override
  Map<String, dynamic> toJson() => {
        'title': title,
        'author': author,
        'publisher': publisher,
        'info': info,
        'url': url,
      };
}
