import 'package:ddgs/ddgs.dart';
import 'package:test/test.dart';

void main() {
  group('DDGS', () {
    test('init with default values', () {
      final ddgs = DDGS();
      // We can't easily check private fields, but we verify it constructs without error
      expect(ddgs, isNotNull);
      ddgs.close();
    });

    test('getAvailableEnginesFor returns keys', () {
      final ddgs = DDGS();
      // 'text' category should have engines (depending on what's registered)
      // Since this unit test might depend on the actual registered engines in src/engines/engines.dart,
      // we at least check it returns a list.
      final engines = ddgs.getAvailableEnginesFor('text');
      expect(engines, isList);
      ddgs.close();
    });
  });
}
