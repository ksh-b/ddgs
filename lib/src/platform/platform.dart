// Default to IO implementation (VM)
// Use conditional import to swap with Web implementation when 'dart:library.html' is available
// or specifically for web compilation.
export 'platform_io.dart'
    if (dart.library.js_interop) 'platform_web.dart'
    if (dart.library.html) 'platform_web.dart';
