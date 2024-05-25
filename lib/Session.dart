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

  Future<bool> verifySessionValue(String key) async {
      var value = await _sessionManager.containsKey(key);
      return value;
  }

  void clearSessionValue(String key) async {
    _sessionManager.remove(key);
  }

  void updateSession() async {
    await _sessionManager.update();
  }

}
