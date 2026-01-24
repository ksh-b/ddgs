@Tags(['integration'])
library;

import 'package:ddgs/ddgs.dart';
import 'package:test/test.dart';

void main() {
  group('Live API', () {
    late DDGS ddgs;

    setUp(() {
      ddgs = DDGS();
    });

    tearDown(() {
      ddgs.close();
    });

    test('text search returns results', () async {
      final results = await ddgs.text('dart programming', maxResults: 2);
      expect(results, isNotEmpty);
      expect(results.first, contains('title'));
      expect(results.first, contains('href'));
    });

    test('images search returns results', () async {
      final results = await ddgs.images('cute cats', maxResults: 2);
      expect(results, isNotEmpty);
      expect(results.first, contains('image'));
    });
  }, skip: 'Live API tests - remove skip to run manually');
}
