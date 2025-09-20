import 'package:logger/logger.dart';

class AppLogger {
  static void d(String message, [dynamic data]) {
    print("🐛 DEBUG: $message ${data ?? ""}");
  }

  static void i(String message, [dynamic data]) {
    print("ℹ️ INFO: $message ${data ?? ""}");
  }

  static void w(String message, [dynamic data]) {
    print("⚠️ WARN: $message ${data ?? ""}");
  }

  static void e(String message, [dynamic error, StackTrace? stackTrace]) {
    print("❌ ERROR: $message ${error ?? ""}");
    if (stackTrace != null) print(stackTrace);
  }
}

