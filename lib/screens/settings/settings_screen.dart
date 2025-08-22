import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/l10n/locale_provider.dart';
import 'package:ips_lacpass_app/models/auth_state_notifier.dart';
import 'package:ips_lacpass_app/models/language_type.dart';
import 'package:ips_lacpass_app/screens/landing/landing_screen.dart';
import 'package:ips_lacpass_app/screens/settings/account_settings/account_settings_screen.dart';
import 'package:ips_lacpass_app/screens/settings/language_screen.dart';
import 'package:ips_lacpass_app/screens/settings/settings_app_bar.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    String localeLabel;
    if (locale == null) {
      localeLabel = AppLocalizations.of(context)!.systemDefault;
    } else if (locale.languageCode == LanguageType.en.name) {
      localeLabel = LanguageType.en.value;
    } else if (locale.languageCode == LanguageType.es.name) {
      localeLabel = LanguageType.es.value;
    } else {
      localeLabel = locale.languageCode;
    }

    return Scaffold(
        appBar: SettingsAppBar(
          title: AppLocalizations.of(context)!.settingsScreenTitle,
        ),
        body: Stack(
          children: [
            SettingsList(
              sections: [
                SettingsSection(
                  tiles: [
                    SettingsTile.navigation(
                      title: Text(
                          AppLocalizations.of(context)!.accountSettingsLabel),
                      enabled: true,
                      onPressed: (context) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AccountSettingsScreen(),
                          ),
                        );
                      },
                    ),
                    SettingsTile.navigation(
                      title: Text(
                          AppLocalizations.of(context)!.languageSettingLabel),
                      value: Text(localeLabel),
                      onPressed: (context) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LanguageScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              left: 32,
              right: 32,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                  onPressed: () {
                    ref.read(authStateProvider.notifier).logout();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => LandingScreen(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(MdiIcons.logoutVariant),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          AppLocalizations.of(context)!.logoutButtonLabel,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onError,
                              fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
