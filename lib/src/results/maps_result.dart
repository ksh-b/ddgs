import 'base_result.dart';

/// Represents a result from a maps search.
class MapsResult extends BaseResult {
  /// Map title.
  final String title;

  /// Map URL.
  final String href;

  /// Map body/snippet.
  final String body;

  /// The formatted address of the location.
  final String address;

  /// The latitude coordinate.
  final double? latitude;

  /// The longitude coordinate.
  final double? longitude;

  /// The source of the map data.
  final String? source;

  /// A description or category of the place.
  final String? description;

  /// Phone number if available.
  final String? phone;

  /// Opening hours if available.
  final String? hours;

  MapsResult({
    required this.title,
    required this.href,
    String? body,
    required this.address,
    this.latitude,
    this.longitude,
    this.source,
    this.description,
    this.phone,
    this.hours,
  }) : body = body ?? '';

  /// Create a [MapsResult] from JSON data.
  factory MapsResult.fromJson(Map<String, dynamic> json) {
    return MapsResult(
      title: json['title'] as String? ?? 'No Title',
      href: json['url'] as String? ?? '',
      body: json['address']
          as String?, // Map body often to address if description missing
      address: json['address'] as String? ?? '',
      latitude: json['latitude'] is String
          ? double.tryParse(json['latitude'] as String)
          : (json['latitude'] as num?)?.toDouble(),
      longitude: json['longitude'] is String
          ? double.tryParse(json['longitude'] as String)
          : (json['longitude'] as num?)?.toDouble(),
      source: json['source'] as String?,
      description: json['description'] as String?,
      phone: json['phone'] as String?,
      hours: json['hours'] as String?,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'href': href,
      'body': body,
      'address': address,
      'latitude': latitude,
      'longitude': longitude,
      'source': source,
      'description': description,
      'phone': phone,
      'hours': hours,
    };
  }
}
