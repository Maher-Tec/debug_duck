import 'package:flutter/foundation.dart';

/// Handles the debug session logging in memory.
class DuckLogger {
  // Singleton instance
  static final DuckLogger _instance = DuckLogger._internal();
  factory DuckLogger() => _instance;
  DuckLogger._internal();

  final List<String> _logs = [];
  DateTime? _startTime;
  bool _isSessionActive = false;

  void startSession() {
    _logs.clear();
    _startTime = DateTime.now();
    _isSessionActive = true;
    if (kDebugMode) {
      print('🦆 DebugDuck: Session started at ${_startTime!.toIso8601String()}');
    }
  }

  void note(String message) {
    if (!_isSessionActive) {
      if (kDebugMode) {
         print('🦆 (No Active Session): $message');
      }
      return;
    }
    final timestamp = DateTime.now();
    // format HH:mm:ss
    final timeStr = "${timestamp.hour}:${timestamp.minute}:${timestamp.second}";
    _logs.add("[$timeStr] $message");
  }

  void endSession() {
    if (!_isSessionActive) return;
    
    _isSessionActive = false;
    final duration = DateTime.now().difference(_startTime!);
    
    if (kDebugMode) {
      print('\n--- 🦆 DebugDuck Session Summary ---');
      print('Duration: ${duration.inMinutes}m ${duration.inSeconds % 60}s');
      print('Notes captured: ${_logs.length}');
      print('------------------------------------');
      for (final log in _logs) {
        print(log);
      }
      print('------------------------------------\n');
    }
  }
  
  // For validation/testing purposes
  List<String> get currentLogs => List.unmodifiable(_logs);
  bool get isSessionActive => _isSessionActive;
}
