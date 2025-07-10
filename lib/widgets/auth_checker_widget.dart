import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/models/user_model.dart';
import 'package:ips_lacpass_app/screens/landing/landing_screen.dart';

class AuthCheckerWidget extends ConsumerWidget {
  final Widget child;
  const AuthCheckerWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.read(isLoggedInProvider);
    if (isLoggedIn) {
      return child;
    } else {
      return LandingScreen();
    }
  }
}