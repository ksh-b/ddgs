import 'platform_interface.dart';

class PlatformImpl implements PlatformAdapter {
  @override
  // Environment variables are not standard in browser
  String? getEnvironmentVariable(String key) => null;

  @override
  bool get isMobile => false; // Simplified check

  @override
  bool get isDesktop => false;

  @override
  bool get isWeb => true;
}

final platform = PlatformImpl();
