import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  Constants._(); //private constructor to prevent instantiation

  static final List<Map<String, String>> countryOptions = [
    {'value': 'AR', 'label': 'Argentina'},
    {'value': 'BS', 'label': 'Bahamas'},
    {'value': 'BB', 'label': 'Barbados'},
    {'value': 'BZ', 'label': 'Belize'},
    {'value': 'BO', 'label': 'Bolivia'},
    {'value': 'BR', 'label': 'Brazil'},
    {'value': 'CL', 'label': 'Chile'},
    {'value': 'CO', 'label': 'Colombia'},
    {'value': 'CR', 'label': 'Costa Rica'},
    {'value': 'EC', 'label': 'Ecuador'},
    {'value': 'SV', 'label': 'El Salvador'},
    {'value': 'GT', 'label': 'Guatemala'},
    {'value': 'HN', 'label': 'Honduras'},
    {'value': 'PA', 'label': 'Panama'},
    {'value': 'PY', 'label': 'Paraguay'},
    {'value': 'PE', 'label': 'Perú'},
    {'value': 'DO', 'label': 'Republica Dominicana'},
    {'value': 'SR', 'label': 'Suriname'},
    {'value': 'UY', 'label': 'Uruguay'}
  ];

  static final RegExp dniRegex = RegExp(r'^[a-zA-Z0-9\-\.\/]{1,16}$');
  static final RegExp passportRegex = RegExp(r'^[a-zA-Z0-9\-\.\/]{1,16}$');

  static final RegExp verificationCodeRegex = RegExp(r'^\d{6}$');

  static final RegExp emailRegex =
      RegExp(r'^((?!\.)[\w\-_.]*[^.])(@\w+)(\.\w+(\.\w+)?[^.\W])$');

  //Backend API
  static final String apiEndpoint = dotenv.env['API_ENDPOINT']!;

  //Keycloak
  static final String keycloakEndpoint = dotenv.env['KEYCLOAK_ENDPOINT']!;
  static final String keycloakRealm = dotenv.env['KEYCLOAK_REALM']!;
  static final String keycloakClientId = dotenv.env['KEYCLOAK_CLIENT_ID']!;
  static final String keycloakRefreshTokenKey =
      dotenv.env['KEYCLOAK_REFRESH_TOKEN_KEY']!;

  //IPS
  static final int ipsExpirationDays = int.parse(dotenv.env['IPS_EXP_DAYS']!);

  //VHL
  static final int vhlExpirationDays =
      int.parse(dotenv.env['VHL_EXPIRATION_DAYS']!);
  static final String vhlPassCode = dotenv.env['VHL_PASS_CODE']!;
}
