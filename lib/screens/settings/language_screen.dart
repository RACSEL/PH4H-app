import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/l10n/locale_provider.dart';
import 'package:ips_lacpass_app/models/language_type.dart';
import 'package:ips_lacpass_app/screens/settings/settings_app_bar.dart';
import 'package:settings_ui/settings_ui.dart';

class LanguageScreen extends ConsumerWidget {
  const LanguageScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locale = ref.watch(localeProvider);

    return Scaffold(
      appBar: SettingsAppBar(
        title: AppLocalizations.of(context)!.languageSettingLabel,
      ),
      body: SettingsList(
        sections: [
          SettingsSection(
            tiles: [
              SettingsTile(
                title: Text(AppLocalizations.of(context)!.systemDefault),
                onPressed: (context) {
                  ref.read(localeProvider.notifier).clearLocale();
                },
                trailing: locale == null
                    ? Icon(
                        Icons.check,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : null,
              ),
              ...LanguageType.values.map((language) {
                return SettingsTile(
                  title: Text(language.value),
                  onPressed: (context) {
                    ref
                        .read(localeProvider.notifier)
                        .setLocale(Locale(language.name));
                  },
                  trailing: locale?.languageCode == language.name
                      ? Icon(
                          Icons.check,
                          color: Theme.of(context).colorScheme.primary,
                        )
                      : null,
                );
              }),
            ],
          ),
        ],
      ),
    );
  }
}
