import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/api/api_manager.dart';
import 'package:ips_lacpass_app/api/auth/token_manager.dart';
import 'package:ips_lacpass_app/api/ips_loader.dart';
import 'package:ips_lacpass_app/models/ips_model.dart';

//Notifier to link the change in Auth Token update with the state of UserModel.
class AuthStateNotifier extends StateNotifier<AsyncValue<(String?, bool)>> {
  final Ref _ref;

  AuthStateNotifier(this._ref) : super(const AsyncValue.loading()) {
    _setToken();
  }

  Future<void> _setToken() async {
    String? token;
    try {
      /*
      We know during build start, tokenManagerProvider.accessToken will be null,
      so we try to update it with the refresh token if this is stored.
       */
      token = await _ref.read(tokenManagerProvider).updateAccessToken();
      final isStored = await IPSLoader.instance.isStored();
      if (mounted) {
        state = AsyncValue.data((token, isStored));
      }
    } catch (e, st) {
      if (mounted) {
        state = AsyncValue.error(e, st);
      }
    }
  }

  Future<void> login(String username, String password) async {
    final response = await ApiManager.instance.login(username, password);
    await _ref.read(tokenManagerProvider).setTokens(
        response.data['access_token'],
        refreshToken: response.data['refresh_token'],
        saveRefreshToken: true);
    state = AsyncValue.data((response.data['access_token'], false));
  }

  Future<void> logout() async {
    final refreshToken =
        await _ref.read(tokenManagerProvider).getRefreshToken();
    if (mounted && refreshToken != null && refreshToken.isNotEmpty) {
      await ApiManager.instance.logout(refreshToken);
      await _ref.read(tokenManagerProvider).clearTokens();
      await _ref.read(ipsModelProvider).clear();
      if (mounted) {
        state = const AsyncValue.data((null, false));
      }
    }
  }

  Future<void> recoverPassword() async {
    try {
      await ApiManager.instance.recoverPassword();
      return;
    } on DioException catch (err, st) {
      if (kDebugMode) {
        debugPrint(err.toString());
        debugPrintStack(
            label: 'AuthStateNotifier.recoverPassword', stackTrace: st);
      }
      rethrow;
    }
  }

  Future<void> register(
      String identifier,
      String email,
      String firstName,
      String lastName,
      String password,
      String passwordConfirm,
      String locale,
      String documentType) async {
    try {
      await ApiManager.instance.register(identifier, email, firstName, lastName,
          password, passwordConfirm, locale, documentType);
      return;
    } on DioException catch (err, st) {
      if (kDebugMode) {
        debugPrint(err.toString());
        debugPrintStack(label: 'AuthStateNotifier.register', stackTrace: st);
      }
      rethrow;
    }
  }

  Future<void> updateUser(String firstName, String lastName) async {
    try {
      await ApiManager.instance.updateUser(firstName, lastName);
      _setToken();
    } on DioException catch (err, st) {
      if (kDebugMode) {
        debugPrint(err.toString());
        debugPrintStack(label: 'AuthStateNotifier.register', stackTrace: st);
      }
      rethrow;
    }
  }
}

final authStateProvider =
    StateNotifierProvider<AuthStateNotifier, AsyncValue<(String?, bool)>>(
        (ref) {
  return AuthStateNotifier(ref);
});
