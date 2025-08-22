import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/models/auth_state_notifier.dart';
import 'package:ips_lacpass_app/models/ips_model.dart';
import 'package:ips_lacpass_app/screens/home/home_screen.dart';
import 'package:ips_lacpass_app/screens/ips_viewer/ips_viewer_screen.dart';
import 'package:ips_lacpass_app/screens/landing/landing_screen.dart';

class LandingAuthCheckerWidget extends ConsumerWidget {
  const LandingAuthCheckerWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    return authState.when(
      data: (data) { //$1 = accessToken, $2 = isIpsStored
        if (data.$1 != null && data.$1!.isNotEmpty) {
          if (data.$2) {
            return IPSViewerScreen(source: IpsSource.national);
          }
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