import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/api/auth/token_manager.dart';
import 'package:ips_lacpass_app/models/auth_state_notifier.dart';
import 'package:jwt_decode/jwt_decode.dart';

class User {
  final String identifier;
  String firstName;
  String lastName;
  final String email;

  User(
      {required this.identifier,
      required this.firstName,
      required this.lastName,
      required this.email});

  factory User.fromClaims(Map<String, dynamic> claims) {
    return User(
        identifier: claims['preferred_username'] ?? '',
        firstName: claims['given_name'] ?? '',
        lastName: claims['family_name'] ?? '',
        email: claims['email'] ?? '');
  }

  @override
  String toString() {
    return 'User(id: $identifier, firstName: $firstName, lastName: $lastName, email: $email)';
  }

  void updateName({String? newFirstName, String? newLastName}) {
    if (newFirstName != null && newFirstName.isNotEmpty) {
      firstName = newFirstName;
    }
    if (newLastName != null && newLastName.isNotEmpty) {
      lastName = newLastName;
    }
  }
}

final userModelProvider = Provider<User?>((ref) {
  final authState = ref.watch(authStateProvider);

  return authState.maybeWhen(
      data: (data) {
        final accessToken = data.$1;
        if (accessToken != null && accessToken.isNotEmpty) {
          try {
            if (Jwt.isExpired(accessToken)) {
              Future(() => ref.read(tokenManagerProvider).updateAccessToken());
              return null;
            }
            Map<String, dynamic> decodedToken = Jwt.parseJwt(accessToken);
            return User.fromClaims(decodedToken);
          } catch (e) {
            //TODO: handle refresh error
            print('Error refresh');
            return null;
          }
        }
        return null;
      },
      orElse: () => null);
});

final isLoggedInProvider = Provider<bool>((ref) {
  final authState = ref.watch(authStateProvider);
  return authState.maybeWhen(
      data: (data) => data.$1 != null && data.$1!.isNotEmpty,
      error: (err, stack) => false,
      orElse: () => false);
});
