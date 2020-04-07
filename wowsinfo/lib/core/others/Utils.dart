import 'dart:io';

import 'package:flutter/foundation.dart';

class Utils {
  /// Takes an `object`, a `path` and a `default value`.
  /// Returns whether the valid value or the default value
  static guard(obj, String path, dval) {
    // check if obj is null
    if (path == '' && obj != null) return obj;
    // check if object is valid and path does not start with or end with '.'
    if (!path.startsWith('.') && !path.endsWith('.')) {
      final p = path.split('.');
      if (p != null && p.length > 0) {
        return p.fold(obj, (curr, key) {
          // Make sure curr is valid
          if (curr != null) {
            final indexKey = int.tryParse(key);
            if (indexKey != null)
              return curr[indexKey] != null ? curr[indexKey] : dval;
            return curr[key] != null ? curr[key] : dval;
          }
        });
      }
    }
    return dval;
  }

  /// Print only in debug mode
  static void debugPrint(Object object) {
    if (kDebugMode) print(object);
  }

  /// A simple wrapper for Future.delayed
  static Future<void> delay(int duration) {
    return Future.delayed(Duration(milliseconds: duration));
  }

  /// Check if this device is IOS
  static bool isIOS() {
    // Web doesn't support platform so prevent calling it
    if (kIsWeb) return false;
    return Platform.isIOS || Platform.isMacOS;
  }
}
