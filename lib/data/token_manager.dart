import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManager {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  static final TokenManager _instance = TokenManager._internal();

  factory TokenManager() => _instance;

  TokenManager._internal();

  Future<String> get accessToken async {
    return await _storage.read(key: 'accessToken') ?? '';
  }

  Future<void> setToken({String? access}) async {
    if (access != null) {
      await _storage.write(key: 'accessToken', value: access);
    }
  }

  Future<void> deleteTokens() async {
    await _storage.delete(key: 'accessToken');
  }
}
