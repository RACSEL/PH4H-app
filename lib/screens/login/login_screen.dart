import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/models/auth_state_notifier.dart';
import 'package:ips_lacpass_app/widgets/patient_form/document_type_select.dart';

import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/widgets/patient_form/national_id_input.dart';
import 'package:ips_lacpass_app/widgets/snackbar.dart';

part 'login_controller.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends LoginController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(32, 17, 32, 46),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        "assets/icon/logo.png",
                        width: 60,
                      ),
                      SizedBox(
                        height: 32,
                      ),
                      Text(AppLocalizations.of(context)!.loginScreenTitle,
                          style: TextStyle(fontSize: 36)),
                      SizedBox(
                        height: 32,
                      ),
                      Expanded(
                          child: Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  DocumentTypeSelect(
                                    selectedValue: _selectedDocumentType,
                                    onChanged: (value) {
                                      setState(() {
                                        _selectedDocumentType = value;
                                      });
                                    },
                                  ),
                                  SizedBox(height: 23),
                                  NationalIdInput(
                                    selectedCountryCode: _selectedCountryCode,
                                    onChangedCountryCode: (value) {
                                      setState(() {
                                        _selectedCountryCode = value;
                                      });
                                    },
                                    id: _inputId,
                                    onChangedId: (value) {
                                      setState(() {
                                        _inputId = value;
                                      });
                                    },
                                    selectedDocumentType: _selectedDocumentType,
                                  ),
                                  SizedBox(height: 23),
                                  TextFormField(
                                    onTapOutside: (PointerDownEvent event) {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                    },
                                    obscureText: true,
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context)!
                                          .passwordInputLabel,
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _inputPassword = newValue;
                                      });
                                    },
                                  ),
                                  SizedBox(
                                    height: 23,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        ref
                                            .read(authStateProvider.notifier)
                                            .recoverPassword();
                                      },
                                      child: Text(AppLocalizations.of(context)!
                                          .forgotPasswordLinkLabel)),
                                  Spacer(),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      FilledButton(
                                          onPressed: _submitting ||
                                                  !_userInteractsWithAllFields() ||
                                                  _formKey.currentState ==
                                                      null ||
                                                  !_formKey.currentState!
                                                      .validate()
                                              ? null
                                              : _submitForm,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .loginButtonLabel,
                                                style: TextStyle(fontSize: 18)),
                                          )),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      OutlinedButton(
                                          onPressed: () {
                                            Navigator.pushNamed(
                                                context, '/signup');
                                          },
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Text(
                                                AppLocalizations.of(context)!
                                                    .createAccountButtonLabel,
                                                style: TextStyle(
                                                    color: Theme.of(context)
                                                        .colorScheme
                                                        .onSurface,
                                                    fontSize: 18)),
                                          )),
                                    ],
                                  )
                                ],
                              ))),
                    ]))));
  }
}
