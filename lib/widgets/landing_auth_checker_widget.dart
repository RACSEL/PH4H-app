import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/models/auth_state_notifier.dart';

class LandingAuthCheckerWidget extends ConsumerWidget {
  const LandingAuthCheckerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (data) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final accessToken = data.$1;
          final isIpsStored = data.$2;

          if (accessToken != null && accessToken.isNotEmpty) {
            if (isIpsStored) {
              Navigator.pushReplacementNamed(context, '/ips');
            } else {
              Navigator.pushReplacementNamed(context, '/home');
            }
          } else {
            Navigator.pushReplacementNamed(context, '/landing');
          }
        });

        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
      error: (err, stack) {
        return const Scaffold(
          body: Center(child: Text('Error loading app')),
        );
      },
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}