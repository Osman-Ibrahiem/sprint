import 'dart:developer' as dev;

abstract final class AppLogger {
  static void debug(String msg, {Object? error, StackTrace? stackTrace}) {
    dev.log(
      msg,
      name: 'Sprint',
      level: 500,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void info(String msg, {Object? error, StackTrace? stackTrace}) {
    dev.log(
      msg,
      name: 'Sprint',
      level: 800,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void warning(String msg, {Object? error, StackTrace? stackTrace}) {
    dev.log(
      msg,
      name: 'Sprint',
      level: 900,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void error(String msg, {Object? error, StackTrace? stackTrace}) {
    dev.log(
      msg,
      name: 'Sprint',
      level: 1000,
      error: error,
      stackTrace: stackTrace,
    );
  }
}
