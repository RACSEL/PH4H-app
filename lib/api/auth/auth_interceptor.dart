import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:ips_lacpass_app/api/api_manager.dart';
import 'package:ips_lacpass_app/api/auth/token_manager.dart';
import 'package:ips_lacpass_app/constants.dart';
import 'package:ips_lacpass_app/utils/navigation_service.dart';

class AuthInterceptor extends QueuedInterceptor {
  final Dio dio;

  AuthInterceptor(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
   if (!requiresAuthentication(options)) {
     handler.next(options);
     return;
   }

   final String? accessToken = TokenManager.instance.getAccessToken();
   if (accessToken != null) {
     options.headers.addAll({'Authorization': 'Bearer $accessToken'});
   } else {
     handler.reject(DioException.badCertificate(requestOptions: options));
     return;
   }
   handler.next(options);
  }

  bool requiresAuthentication(RequestOptions options) {
    //paths with no authentication
    final noAuthPaths = [
      '/users',                                                             //register
      '/realms/${Constants.keycloakRealm}/protocol/openid-connect/token',   //login
      '/realms/${Constants.keycloakRealm}/protocol/openid-connect/logout',  //logout
    ];
    return !noAuthPaths.any((path) => options.path.endsWith(path));
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != 401 || !requiresAuthentication(err.requestOptions)) {
      super.onError(err, handler);
      return;
    }
    await handleUnauthorizedError(err, handler);
  }

  Future<void> handleUnauthorizedError(DioException err, ErrorInterceptorHandler handler) async {
    TokenManager tokenManager = TokenManager.instance;
    final String? refreshToken = await tokenManager.getRefreshToken();
    if (refreshToken == null) {
      //Nothing to do, just clear and redirect to login if possible
      final context = NavigationService.navigatorKey.currentContext;
      if (context != null) {
        tokenManager.clearTokens();
        if (context.mounted) {
          Navigator.of(context).pushNamed('/login');
        }
      } else {
        if (kDebugMode) {
          final e = Exception('Context is null');
          debugPrint(e.toString());
          debugPrintStack(label: 'AuthInterceptor.handleUnauthorizedError', stackTrace: StackTrace.current);
        }
        return;
      }
      super.onError(err, handler);
      return;
    }

    final response = await (ApiManager.instance).refreshToken(refreshToken);
    if (response.statusCode != 200) {
      tokenManager.clearTokens();
      final context = NavigationService.navigatorKey.currentContext;
      if (context != null ) {
        if (context.mounted) {
          Navigator.of(context).pushNamed('/login');
        }
      } else {
        //TODO: handle null context
      }
      super.onError(err, handler);
    }

    //success, update token and retry request
    try {
      await TokenManager.instance.setTokens(
          response.data['access_token'],
          refreshToken: response.data['refresh_token'],
          saveRefreshToken: true
      );
      final newAccessToken = response.data['access_token'];
      if (newAccessToken == null) {
        final context = NavigationService.navigatorKey.currentContext;
        if (context != null) {
          if (context.mounted) {
            Navigator.of(context).pushNamed('/login');
          }
        } else {
          //TODO: handle null context
        }
      }
      await retryRequestWithNewToken(err, handler, newAccessToken!);
    } on DioException catch (err) {
      super.onError(err, handler);
      TokenManager.instance.clearTokens();
    }
  }

  Future<void> retryRequestWithNewToken(DioException err, ErrorInterceptorHandler handler, String newToken) async {
    final updatedOptions = Options(
      method: err.requestOptions.method,
      headers: err.requestOptions.headers..addAll({'Authorization': 'Bearer $newToken'})
    );

    try {
      final response = await dio.request(
        err.requestOptions.path,
        data: err.requestOptions.data,
        queryParameters: err.requestOptions.queryParameters,
        options: updatedOptions
      );
      handler.resolve(response);
    } catch (retryError, retryStackTrace) {
      handler.reject(DioException(
        requestOptions: err.requestOptions,
        error: retryError,
        stackTrace: retryStackTrace
      ));
    }
  }
}