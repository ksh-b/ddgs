import 'package:ddgs/src/search_result.dart';
import 'package:test/test.dart';

void main() {
  group('TextSearchResult', () {
    test('fromJson parses correct data', () {
      final json = {
        'title': 'Dart',
        'href': 'https://dart.dev',
        'body': 'Dart is a client-optimized language.',
      };

      final result = TextSearchResult.fromJson(json);

      expect(result.title, 'Dart');
      expect(result.href, 'https://dart.dev');
      expect(result.body, 'Dart is a client-optimized language.');
    });

    test('fallback keys work (url/description)', () {
      final json = {
        'title': 'Dart',
        'url': 'https://dart.dev',
        'description': 'Description here',
      };

      final result = TextSearchResult.fromJson(json);

      expect(result.href, 'https://dart.dev');
      expect(result.body, 'Description here');
    });

    test('toJson returns correct map', () {
      final result = TextSearchResult(
        title: 'Title',
        href: 'https://example.com',
        body: 'Body text',
        provider: 'duckduckgo',
      );

      final json = result.toJson();

      expect(json['title'], 'Title');
      expect(json['href'], 'https://example.com');
      expect(json['provider'], 'duckduckgo');
    });
  });

  group('SearchResult sealed class', () {
    test('fromJson instantiates correct subclass', () {
      final textJson = {'title': 'T', 'href': 'H', 'body': 'B'};
      expect(SearchResult.fromJson(textJson, 'text'), isA<TextSearchResult>());

      final imageJson = {
        'title': 'T',
        'image': 'I',
        'thumbnail': 'Th',
        'url': 'U'
      };
      expect(
          SearchResult.fromJson(imageJson, 'image'), isA<ImageSearchResult>());
    });
  });
}
