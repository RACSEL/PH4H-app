import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/cupertino.dart';
import 'package:ips_lacpass_app/api/auth/auth_interceptor.dart';
import 'package:ips_lacpass_app/constants.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import 'package:ips_lacpass_app/models/credential_type.dart';

class ApiManager {
  static final ApiManager _instance = ApiManager._internal(); //singleton class
  static final Dio dio = Dio();

  factory ApiManager() {
    return _instance;
  }

  ApiManager._internal() {
    dio.interceptors.add(AuthInterceptor(dio));

    if (Constants.debugMode) {
      dio.interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ));
    }

    if ((Platform.isAndroid || Platform.isIOS) && Constants.useHttp) {
      (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (client) {
        var allowedHosts = {
          Constants.apiEndpoint.split('//')[1],
          Constants.keycloakEndpoint.split('//')[1]
        };

        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          return allowedHosts.contains(host);
        };
        return client;
      };
    }
  }

  static ApiManager get instance {
    return _instance;
  }

  Future<Response> refreshToken(String token) async {
    return dio.post(
        '${Constants.keycloakEndpoint}/realms/${Constants.keycloakRealm}/protocol/openid-connect/token',
        options: Options(
            headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
        data: {
          'client_id': Constants.keycloakClientId,
          'refresh_token': token,
          'grant_type': 'refresh_token',
        });
  }

  Future<Response> login(String username, String password) async {
    try {
      final Response response = await dio.post(
          '${Constants.keycloakEndpoint}/realms/${Constants.keycloakRealm}/protocol/openid-connect/token',
          options: Options(
              headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
          data: {
            'client_id': Constants.keycloakClientId,
            'username': username,
            'password': password,
            'grant_type': 'password',
          });
      return response;
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Response> logout(String refreshToken) async {
    try {
      final Response response = await dio.post(
          '${Constants.keycloakEndpoint}/realms/${Constants.keycloakRealm}/protocol/openid-connect/logout',
          options: Options(
              headers: {'Content-Type': 'application/x-www-form-urlencoded'}),
          data: {
            'client_id': 'app',
            'refresh_token': refreshToken,
          });
      return response;
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Response> register(
      String identifier,
      String email,
      String firstName,
      String lastName,
      String password,
      String passwordConfirm,
      String locale,
      String documentType) async {
    try {
      final data = {
        'username': identifier,
        'email': email,
        'password': password,
        'password_confirm': passwordConfirm,
        'first_name': firstName,
        'last_name': lastName,
        'locale': locale == 'null' ? 'en' : locale,
        'document_type': documentType,
        'identifier': identifier,
      };
      final Response response = await dio.post('${Constants.apiEndpoint}/users',
          options: Options(headers: {'Content-Type': 'application/json'}),
          data: data);
      return response;
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<void> recoverPassword() async {
    Uri recoverPasswordUrl = Uri.parse(
      '${Constants.keycloakEndpoint}/realms/${Constants.keycloakRealm}/login-actions/reset-credentials',
    );
    if (!await launchUrl(
      recoverPasswordUrl,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $recoverPasswordUrl');
    }
  }

  Future<Response> getIps() async {
    try {
      final Response response = await dio.get(
        '${Constants.apiEndpoint}/ips',
      );
      return response;
    } catch (e) {
      // debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Response> updateUser(
    String firstName,
    String lastName,
  ) async {
    try {
      final data = {
        'first_name': firstName,
        'last_name': lastName,
      };
      final Response response =
          await dio.put('${Constants.apiEndpoint}/users/auth/update',
              options: Options(headers: {
                'Content-Type': 'application/json',
              }),
              data: data);
      return response;
    } on Exception catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Response> getVHL(Map<String, dynamic> bundle, String passcode) async {
    try {
      final Response response = await dio.post('${Constants.apiEndpoint}/qr',
          options: Options(headers: {
            'Content-Type': 'application/json',
          }),
          data: {
            "content": jsonEncode(bundle),
            "expires_on": DateTime.now()
                .add(Duration(days: Constants.vhlExpirationDays))
                .toIso8601String(),
            "pass_code": passcode
          });
      return response;
    } catch (error) {
      rethrow;
    }
  }

  Future<Response> getIpsVhl(String vhlCode, String passcode) async {
    try {
      final Response response = await dio.post(
          '${Constants.apiEndpoint}/qr/fetch',
          options: Options(headers: {
            'Content-Type': 'application/json',
          }),
          data: {
            "data": vhlCode,
            "pass_code": passcode
          });
      return response;
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Response> mergeIps(
      Map<String, dynamic> currentIps, Map<String, dynamic> newIps) async {
    try {
      final Response response =
          await dio.post('${Constants.apiEndpoint}/ips/merge',
              options: Options(headers: {
                'Content-Type': 'application/json',
              }),
              data: {"current_ips": currentIps, "new_ips": newIps});
      return response;
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Response> vaccinationCertificate(
      String bundleId, String? immunizationId) async {
    try {
      Map<String, String> params = {"bundleId": bundleId};
      if (immunizationId != null) {
        params["immunizationId"] = immunizationId;
      }
      final Response response =
          await dio.get('${Constants.apiEndpoint}/ips/icvp',
              options: Options(headers: {
                'Content-Type': 'application/json',
              }),
              queryParameters: params);
      return response;
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Response> getWalletUrl(dynamic payload, CredentialType type) async {
    try {
      final Response response = await dio.post(
        '${Constants.apiEndpoint}/wallet/generate-link',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
        data: {"claims": payload, "credentialType": type.value},
      );
      return response;
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Response> validateICVP(String qrData) async {
    try {
      final Response response =
          await dio.post('${Constants.apiEndpoint}/qr/validate',
              options: Options(headers: {
                'Content-Type': 'application/json',
              }),
              data: {"data": qrData});
      return response;
    } on DioException catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
