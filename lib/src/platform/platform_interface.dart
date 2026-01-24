/// Interface for platform-specific operations.
abstract class PlatformAdapter {
  /// Get environment variable.
  String? getEnvironmentVariable(String key);

  /// Check if running on mobile.
  bool get isMobile;

  /// Check if running on desktop (implied if not web/mobile for now, or explicit check).
  bool get isDesktop;

  /// Check if running on web.
  bool get isWeb;
}
