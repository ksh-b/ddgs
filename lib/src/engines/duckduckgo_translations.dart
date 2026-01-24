/// DuckDuckGo Translations search engine implementation.
library;

import '../base_search_engine.dart';
import '../results.dart';

/// DuckDuckGo Translations search engine.
///
/// Note: This is an experimental implementation.
class DuckDuckGoTranslationsEngine extends BaseSearchEngine<TranslationResult> {
  DuckDuckGoTranslationsEngine({super.proxy, super.timeout, super.verify});

  @override
  String get name => 'duckduckgo_translations';

  @override
  String get category => 'translations';

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
    // For translation, we often want to append "translation" or "translate" to query
    // if it's not present, or rely on 'ia=web' which might trigger instant answers.
    // However, since we are scraping HTML, we might just look for standard results
    // that look like translations.

    return {
      'q': 'translate $query', // Force translation intent
      'kl': region,
    };
  }

  @override
  List<TranslationResult> extractResults(String htmlText) {
    final results = <TranslationResult>[];
    final document = extractTree(htmlText);
    final items = document.querySelectorAll(itemsSelector);

    for (final item in items) {
      final titleElement = item.querySelector(elementsSelector['title']!);
      final snippetElement = item.querySelector(elementsSelector['snippet']!);
      final hrefElement = item.querySelector(elementsSelector['href']!);

      final title = titleElement?.text.trim() ?? '';
      final snippet = snippetElement?.text.trim() ?? '';
      final href = hrefElement?.attributes['href']?.trim() ?? '';

      if (title.isNotEmpty &&
          (snippet.isNotEmpty ||
              href.contains('translate') ||
              href.contains('dictionary'))) {
        results.add(TranslationResult(
          sourceText:
              'Query', // Placeholder as we can't easily extract the exact source from generic HTML
          translatedText: snippet.isNotEmpty ? snippet : title,
          detectedLanguage: 'auto',
          targetLanguage: 'en', // Default assumption
          href: href,
        ));
      }
    }

    return results;
  }
}
