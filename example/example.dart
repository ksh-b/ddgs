/// A comprehensive example demonstrating the capabilities of the DDGS library.
///
/// This example covers:
/// 1. Basic Text Search
/// 2. Advanced Text Search (Region, SafeSearch, Time Limit)
/// 3. Strongly-Typed Media Search (Images, Videos, News)
/// 4. Instant Answers & Suggestions
/// 5. Robust Error Handling & Caching
library;

import 'dart:io';

import 'package:ddgs/ddgs.dart';

void main() async {
  // 1. Initialize the DDGS client.
  // Using explicit CacheConfig.memory ensures repetitive queries are cached.
  final ddgs = DDGS(cacheConfig: CacheConfig.memory);

  try {
    print('🚀 DDGS Library Example\n');

    // --- Section 1: Basic Text Search ---
    await _demonstrateBasicSearch(ddgs);

    // --- Section 2: Advanced Options ---
    await _demonstrateAdvancedOptions(ddgs);

    // --- Section 3: Typed Media Search ---
    await _demonstrateMediaSearch(ddgs);

    // --- Section 4: Instant Answers & Suggestions ---
    await _demonstrateInstantFeatures(ddgs);

    print('\n✨ Example completed successfully!');
  } catch (e) {
    stderr.writeln('❌ An unexpected error occurred: $e');
  } finally {
    // 2. Always close the client to release resources (http client, cache).
    ddgs.close();
  }
}

/// Demonstrates simple text search returning raw Map results.
Future<void> _demonstrateBasicSearch(DDGS ddgs) async {
  print('--- 1. Basic Text Search ---');
  print('Searching for "Dart programming"...');

  // .text() returns specific data fields as a List<Map<String, dynamic>>.
  // This is useful when you need raw data or valid JSON output.
  final results = await ddgs.text(
    'Dart programming',
    maxResults: 2,
  );

  for (final result in results) {
    print('  • ${result['title']}');
    print('    ${result['href']}');
  }
  print('');
}

/// Demonstrates using strongly-typed classes and search options.
Future<void> _demonstrateAdvancedOptions(DDGS ddgs) async {
  print('--- 2. Advanced Search Options ---');
  print(
      'Searching for "Python" (Region: UK, SafeSearch: Strict, Time: Past Day)...');

  // .textTyped() returns List<Result> objects for type safety.
  final results = await ddgs.textTyped(
    'Python',
    region: 'uk-en',
    safesearch: 'on', // 'on', 'moderate', or 'off'
    timelimit: 'd', // 'd' (day), 'w' (week), 'm' (month), 'y' (year)
    options: const SearchOptions(maxResults: 2),
  );

  for (final result in results) {
    print('  • ${result.title}');
    // Truncate body for cleaner output
    final snippet = result.body.length > 60
        ? '${result.body.substring(0, 60)}...'
        : result.body;
    print('    $snippet');
  }
  print('');
}

/// Demonstrates searching for Images, Videos, and News with typed results.
Future<void> _demonstrateMediaSearch(DDGS ddgs) async {
  print('--- 3. Media Search ---');

  // Images
  print('📸 Searching Images ("Northern Lights")...');
  final images = await ddgs.imagesTyped(
    'Northern Lights',
    options: const SearchOptions(maxResults: 1),
  );
  if (images.isNotEmpty) {
    final img = images.first;
    print('  • ${img.title}');
    print('    Source: ${img.source}');
    print('    Image:  ${img.imageUrl}');
  }

  // Videos
  print('\n🎥 Searching Videos ("Flutter widget of the week")...');
  final videos = await ddgs.videosTyped(
    'Flutter widget of the week',
    options: const SearchOptions(maxResults: 1),
  );
  if (videos.isNotEmpty) {
    final vid = videos.first;
    print('  • ${vid.title}');
    print('    Duration: ${vid.duration}');
    print('    Publisher: ${vid.publisher}');
  }

  // News
  print('\n📰 Searching News ("AI Technology")...');
  final news = await ddgs.newsTyped(
    'AI Technology',
    options: const SearchOptions(maxResults: 1),
  );
  if (news.isNotEmpty) {
    final article = news.first;
    print('  • ${article.title}');
    print('    Source: ${article.source} (${article.relativeTime})');
  }
  print('');
}

/// Demonstrates Instant Answers (Calculator, Facts) and Autocomplete.
Future<void> _demonstrateInstantFeatures(DDGS ddgs) async {
  print('--- 4. Instant Answers & Suggestions ---');

  // Instant Answer
  const query = 'calories in an apple';
  print('⚡ Instant Answer for "$query":');
  final answer = await ddgs.instantAnswer(query);

  if (answer != null && answer.hasContent) {
    print('  ${answer.answer}');
    print('  Source: ${answer.source}');
  } else {
    print('  No instant answer found.');
  }

  // Suggestions
  const partialQuery = 'flutter pro';
  print('\n🔍 Suggestions for "$partialQuery":');
  final suggestions = await ddgs.suggestions(partialQuery);

  for (final s in suggestions.take(3)) {
    print('  • ${s.suggestion}');
  }
  print('');
}
