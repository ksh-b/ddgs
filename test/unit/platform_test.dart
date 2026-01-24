@TestOn('vm')
library;

import 'dart:io';
import 'package:ddgs/ddgs.dart';
import 'package:ddgs/src/platform/platform.dart';
import 'package:test/test.dart';

void main() {
  group('Platform Compatibility', () {
    test('library initializes on supported VM platforms', () {
      print(
          'Running on: ${Platform.operatingSystem} (${Platform.operatingSystemVersion})');

      final ddgs = DDGS();
      expect(ddgs, isNotNull);
      ddgs.close();
    });

    test('Platform abstraction reports correct environment', () {
      // Since we are running in the test runner (VM)
      expect(platform.isWeb, isFalse);
      expect(platform.isDesktop || platform.isMobile, isTrue);

      // Verify env var reading works (at least doesn't crash)
      final env = platform.getEnvironmentVariable('PATH');
      expect(env, isNotNull); // PATH should exist on all OSs
    });
  });
}
