/// Base result classes.
library;

import '../utils.dart';

/// Base class for all results. Contains normalization functions.
abstract class BaseResult {
  static final Map<String, String Function(String)> _normalizers = {
    'title': normalizeText,
    'body': normalizeText,
    'href': normalizeUrl,
    'url': normalizeUrl,
    'thumbnail': normalizeUrl,
    'image': normalizeUrl,
    'date': normalizeDate,
    'author': normalizeText,
    'publisher': normalizeText,
    'info': normalizeText,
  };

  /// Normalize a field value if a normalizer exists.
  String normalizeField(String fieldName, String value) {
    final normalizer = _normalizers[fieldName];
    return normalizer != null ? normalizer(value) : value;
  }

  Map<String, dynamic> toJson();
}

/// Results aggregator for deduplication.
class ResultsAggregator<T extends BaseResult> {
  ResultsAggregator(this._uniqueFields);
  final List<T> _results = [];
  final Set<String> _seenKeys = {};
  final Set<String> _uniqueFields;

  void add(T result) {
    final json = result.toJson();
    final key = _uniqueFields
        .map((field) => json[field]?.toString() ?? '')
        .where((val) => val.isNotEmpty)
        .join('|');

    if (key.isNotEmpty && !_seenKeys.contains(key)) {
      _seenKeys.add(key);
      _results.add(result);
    }
  }

  void addAll(List<T> results) {
    for (final result in results) {
      add(result);
    }
  }

  List<T> get results => List.unmodifiable(_results);
  int get length => _results.length;
}
