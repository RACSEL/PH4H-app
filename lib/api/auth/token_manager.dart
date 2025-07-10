import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ips_lacpass_app/api/api_manager.dart';
import 'package:ips_lacpass_app/constants.dart';

class TokenManager{
  static final TokenManager _instance = TokenManager._internal(); //singleton class
  String? _accessToken;

  late FlutterSecureStorage _secureStorage;

  TokenManager._internal() {
    _secureStorage = const FlutterSecureStorage();
  }

  static TokenManager get instance {
    return _instance;
  }

  Future<void> setTokens(String accessToken, {String? refreshToken, bool saveRefreshToken = false}) async {
    _accessToken = accessToken;
    if (refreshToken != null && saveRefreshToken) {
      await _secureStorage.write(key: Constants.keycloakRefreshTokenKey, value: refreshToken);
    }
  }

  Future<String?> getRefreshToken() async {
    try {
      return await _secureStorage.read(key: Constants.keycloakRefreshTokenKey);
    } catch (e, st) {
      if (kDebugMode) {
        debugPrint(e.toString());
        debugPrintStack(label: 'TokenManager.getRefreshToken', stackTrace: st);
      }
      return null;
    }
  }

  String? getAccessToken() {
    return _accessToken;
  }

  Future<String?> updateAccessToken() async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null) {
      clearTokens();
      return null;
    }
    try {
      final response = await (ApiManager.instance).refreshToken(refreshToken);
      await setTokens(
          response.data['access_token'],
          refreshToken: response.data['refresh_token'],
          saveRefreshToken: true
      );
      return _accessToken;
    } on DioException{
      clearTokens();
      return null;
    }
  }

  Future<void> clearTokens() async {
    await _secureStorage.delete(key: Constants.keycloakRefreshTokenKey);
    _accessToken = null;
  }
}

final tokenManagerProvider = Provider<TokenManager>((ref) {
  return TokenManager.instance;
});