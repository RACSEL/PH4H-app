import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/models/auth_state_notifier.dart';
import 'package:ips_lacpass_app/screens/home/home_screen.dart';
import 'package:ips_lacpass_app/screens/landing/landing_screen.dart';

class LandingAuthCheckerWidget extends ConsumerWidget {
  const LandingAuthCheckerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (accessToken) {
        if (accessToken != null && accessToken.isNotEmpty) {
          return HomeScreen();
        } else {
          return LandingScreen();
        }
      },
      error: (err, stack) {
        return LandingScreen();
      },
      loading: () => Scaffold(body:
        Center(child: CircularProgressIndicator())
      )
    );
  }
}