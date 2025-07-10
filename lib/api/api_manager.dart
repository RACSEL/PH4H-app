import 'package:dio/dio.dart';
import 'package:ips_lacpass_app/api/auth/auth_interceptor.dart';
import 'package:ips_lacpass_app/constants.dart';

class ApiManager {
  static final ApiManager _instance = ApiManager._internal(); //singleton class
  static final Dio dio = Dio();

  factory ApiManager() {
    return _instance;
  }

  ApiManager._internal() {
    dio.interceptors.add(AuthInterceptor(dio));
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
      Stream.error(e);
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
      Stream.error(e);
      return Future.error(e);
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
      Stream.error(e);
      return Future.error(e);
    }
  }

  Future<Response> getIps() async {
    try {
      final Response response = await dio.get(
        '${Constants.apiEndpoint}/ips',
      );
      return response;
    } on DioException catch (e) {
      Stream.error(e);
      return Future.error(e);
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
      final Response response = await dio.put(
          '${Constants.apiEndpoint}/users/auth/update',
          options: Options(
              headers: {
                'Content-Type': 'application/json',
              }
          ),
          data: data
      );
      return response;
    } on Exception catch (e) {
      return Future.error(e);
    }
  }

  Future<Response> getVHL(Map<String, dynamic> bundle) async {
    try {
      final Response response = await dio.post(
        '${Constants.apiEndpoint}/qr',
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          }
        ),
        data: {
          "content": bundle.toString(),
          "expires_on": DateTime.now().add(Duration(days: Constants.vhlExpirationDays)).toIso8601String(),
          "pass_code": Constants.vhlPassCode
        }
      );
      return response;
    } on DioException catch (e) {
      Stream.error(e);
      return Future.error(e);
    }
  }
}