import 'dart:io';
import 'platform_interface.dart';

class PlatformImpl implements PlatformAdapter {
  @override
  String? getEnvironmentVariable(String key) => Platform.environment[key];

  @override
  bool get isMobile => Platform.isAndroid || Platform.isIOS;

  @override
  bool get isDesktop =>
      Platform.isLinux || Platform.isMacOS || Platform.isWindows;

  @override
  bool get isWeb => false;
}

final platform = PlatformImpl();
