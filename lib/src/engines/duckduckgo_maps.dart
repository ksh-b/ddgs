/// DuckDuckGo Maps search engine implementation.
library;

import '../base_search_engine.dart';
import '../results.dart';

/// DuckDuckGo Maps search engine.
///
/// Note: This is an experimental implementation.
class DuckDuckGoMapsEngine extends BaseSearchEngine<MapsResult> {
  DuckDuckGoMapsEngine({super.proxy, super.timeout, super.verify});

  @override
  String get name => 'duckduckgo_maps';

  @override
  String get category => 'maps';

  @override
  String get provider => 'duckduckgo';

  @override
  String get searchUrl => 'https://duckduckgo.com/html/';

  @override
  String get searchMethod => 'GET';

  @override
  String get itemsSelector => '.result';

  @override
  Map<String, String> get elementsSelector => {
        'title': '.result__title',
        'href': '.result__url',
        'snippet': '.result__snippet',
        'address': '.result__address', // Hypothetical selector
      };

  @override
  Map<String, String> buildPayload({
    required String query,
    required String region,
    required String safesearch,
    String? timelimit,
    int page = 1,
    Map<String, dynamic>? extra,
  }) {
    final safesearchMap = {'on': '1', 'moderate': '0', 'off': '-1'};

    return {
      'q': query,
      'kl': region,
      'p': safesearchMap[safesearch.toLowerCase()] ?? '0',
      'ia': 'maps', // Hint for maps
      'iaxm': 'maps', // Another possibilities
    };
  }

  @override
  List<MapsResult> extractResults(String htmlText) {
    final results = <MapsResult>[];
    final document = extractTree(htmlText);
    final items = document.querySelectorAll(itemsSelector);

    for (final item in items) {
      final titleElement = item.querySelector(elementsSelector['title']!);
      final hrefElement = item.querySelector(elementsSelector['href']!);
      final snippetElement = item.querySelector(elementsSelector['snippet']!);

      final title = titleElement?.text.trim() ?? '';
      final href = hrefElement?.attributes['href']?.trim() ?? '';
      final snippet = snippetElement?.text.trim() ?? '';

      // Basic heuristic to identify identifying map/location results
      // In a real implementation, we'd look for specific map data attributes
      if (title.isNotEmpty) {
        // Fallback: use snippet as address/description if we can't parse it
        results.add(MapsResult(
          title: title,
          href: href,
          address: snippet, // Using snippet as address for now
          description: snippet,
          source: 'DuckDuckGo',
        ));
      }
    }

    return results;
  }
}
