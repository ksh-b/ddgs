import 'base_result.dart';

/// Represents a result from a translation request.
class TranslationResult extends BaseResult {
  /// Derived title.
  final String title;

  /// Derived body.
  final String body;

  /// The detected language of the source text.
  final String detectedLanguage;

  /// The translated text.
  final String translatedText;

  /// The original source text.
  final String sourceText;

  /// The target language code.
  final String targetLanguage;

  /// The URL of the result.
  final String href;

  TranslationResult({
    required this.detectedLanguage,
    required this.translatedText,
    required this.sourceText,
    required this.targetLanguage,
    required this.href,
  })  : title = 'Translation: $sourceText -> $translatedText',
        body = translatedText;

  /// Create a [TranslationResult] from JSON data.
  factory TranslationResult.fromJson(Map<String, dynamic> json) =>
      TranslationResult(
        detectedLanguage: json['detected_language'] as String? ?? 'auto',
        translatedText: json['translated_text'] as String? ?? '',
        sourceText: json['source_text'] as String? ?? '',
        targetLanguage: json['target_language'] as String? ?? '',
        href: json['url'] as String? ?? '',
      );

  @override
  Map<String, dynamic> toJson() => {
        'detected_language': detectedLanguage,
        'translated_text': translatedText,
        'source_text': sourceText,
        'target_language': targetLanguage,
        'title': title,
        'body': body,
        'url': href,
      };
}
