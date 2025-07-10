import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:ips_lacpass_app/constants.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/models/auth_state_notifier.dart';
import 'package:ips_lacpass_app/models/user_model.dart';
import 'package:ips_lacpass_app/screens/settings/settings_app_bar.dart';
import 'package:ips_lacpass_app/widgets/snackbar.dart';

part 'account_settings_controller.dart';

class AccountSettingsScreen extends ConsumerStatefulWidget {
  const AccountSettingsScreen({super.key});

  @override
  ConsumerState<AccountSettingsScreen> createState() =>
      _AccountSettingsScreen();
}

class _AccountSettingsScreen extends AccountSettingsController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: SettingsAppBar(
          title: AppLocalizations.of(context)!.accountSettingsLabel,
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 17, 32, 10),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!
                              .accountSettingsScreenTitle,
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      initialValue: _identifier,
                      enableSuggestions: false,
                      autocorrect: false,
                      enabled: false,
                      decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context)!.identifierInputLabel,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 23),
                    TextFormField(
                      initialValue: _inputEmail,
                      onTapOutside: (PointerDownEvent event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      enableSuggestions: false,
                      autocorrect: false,
                      enabled: false,
                      decoration: InputDecoration(
                        labelText:
                        AppLocalizations.of(context)!.emailInputLabel,
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (newValue) {
                      },
                      validator: _inputEmailValidator,
                    ),
                    SizedBox(height: 23),
                    TextFormField(
                      initialValue: _inputFirstName,
                      onTapOutside: (PointerDownEvent event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context)!.firstNameInputLabel,
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          _inputFirstName = newValue;
                        });
                      },
                      validator: _inputFirstNameValidator,
                    ),
                    SizedBox(height: 23),
                    TextFormField(
                      initialValue: _inputLastName,
                      onTapOutside: (PointerDownEvent event) {
                        FocusManager.instance.primaryFocus?.unfocus();
                      },
                      enableSuggestions: false,
                      decoration: InputDecoration(
                        labelText:
                            AppLocalizations.of(context)!.lastNameInputLabel,
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          _inputLastName = newValue;
                        });
                      },
                      validator: _inputLastNameValidator,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 32,
              right: 32,
              bottom: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  onPressed: _submitting || !_userInteractsWithSomeField() ||
                          _formKey.currentState == null ||
                          !_formKey.currentState!.validate()
                      ? null
                      : _submitForm,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.updateButtonLabel,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
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
