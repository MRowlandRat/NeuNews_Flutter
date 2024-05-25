import 'package:flutter_session_manager/flutter_session_manager.dart';

class SessionManagerSingleton {
  static final SessionManagerSingleton _instance = SessionManagerSingleton._internal();
  final SessionManager _sessionManager = SessionManager();

  SessionManagerSingleton._internal();

  factory SessionManagerSingleton() {
    return _instance;
  }

  Future<void> setSessionValues(dynamic key, dynamic value) async {
    await _sessionManager.set(key, value);
  }

  Future<String> getSessionValue(String key) async {
    var value = await _sessionManager.get(key);
    return value ?? '';
  }
}
