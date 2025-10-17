import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  Constants._(); //private constructor to prevent instantiation

  static final List<Map<String, String>> countryOptions = [
    {'value': 'AR', 'label': 'Argentina', 'emoji': '🇦🇷'},
    {'value': 'BS', 'label': 'Bahamas', 'emoji': '🇧🇸'},
    {'value': 'BB', 'label': 'Barbados', 'emoji': '🇧🇧'},
    {'value': 'BZ', 'label': 'Belize', 'emoji': '🇧🇿'},
    {'value': 'BO', 'label': 'Bolivia', 'emoji': '🇧🇴'},
    {'value': 'BR', 'label': 'Brazil', 'emoji': '🇧🇷'},
    {'value': 'CL', 'label': 'Chile', 'emoji': '🇨🇱'},
    {'value': 'CO', 'label': 'Colombia', 'emoji': '🇨🇴'},
    {'value': 'CR', 'label': 'Costa Rica', 'emoji': '🇨🇷'},
    {'value': 'EC', 'label': 'Ecuador', 'emoji': '🇪🇨'},
    {'value': 'SV', 'label': 'El Salvador', 'emoji': '🇸🇻'},
    {'value': 'GT', 'label': 'Guatemala', 'emoji': '🇬🇹'},
    {'value': 'HN', 'label': 'Honduras', 'emoji': '🇭🇳'},
    {'value': 'PA', 'label': 'Panama', 'emoji': '🇵🇦'},
    {'value': 'PY', 'label': 'Paraguay', 'emoji': '🇵🇾'},
    {'value': 'PE', 'label': 'Perú', 'emoji': '🇵🇪'},
    {'value': 'DO', 'label': 'Republica Dominicana', 'emoji': '🇩🇴'},
    {'value': 'SR', 'label': 'Suriname', 'emoji': '🇸🇷'},
    {'value': 'UY', 'label': 'Uruguay', 'emoji': '🇺🇾'}
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

  // Wallet
  static final bool showWallet = dotenv.env['SHOW_WALLET'] == '1';

  // General
  static final bool useHttp = dotenv.env['USE_HTTP'] == '1';
  static final bool debugMode = dotenv.env['DEBUG_MODE'] == '1';
}
