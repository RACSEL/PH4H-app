import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/l10n/locale_provider.dart';
import 'package:ips_lacpass_app/screens/forgot_password/forgot_password_screen.dart';
import 'package:ips_lacpass_app/screens/home/home_screen.dart';
import 'package:ips_lacpass_app/screens/ips_viewer/ips_viewer_screen.dart';
import 'package:ips_lacpass_app/screens/landing/landing_screen.dart';
import 'package:ips_lacpass_app/screens/login/login_screen.dart';
import 'package:ips_lacpass_app/screens/signup/signup_screen.dart';
import 'package:ips_lacpass_app/screens/verify_account/verify_account_screen.dart';

import 'package:ips_lacpass_app/styles/theme.dart';
import 'package:ips_lacpass_app/utils/navigation_service.dart';
import 'package:ips_lacpass_app/widgets/auth_checker_widget.dart';
import 'package:ips_lacpass_app/widgets/landing_auth_checker_widget.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ),
  );

  runApp(ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);
    return MaterialApp(
        locale: locale,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        theme: appTheme,
        navigatorKey: NavigationService.navigatorKey,
        home: LandingAuthCheckerWidget(),
        routes: {
          '/landing': (context) => LandingScreen(),
          '/login': (context) => LoginScreen(),
          '/signup': (context) => SignupScreen(),
          '/forgot-password': (context) => ForgotPasswordScreen(),
          '/verify-account': (context) => VerifyAccountScreen(),
          '/home': (context) => AuthCheckerWidget(child: HomeScreen()),
          '/ips': (context) => AuthCheckerWidget(child: IPSViewerScreen()),
        });
  }
}
