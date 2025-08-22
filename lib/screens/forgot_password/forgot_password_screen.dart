import 'package:flutter/material.dart';

import 'package:ips_lacpass_app/constants.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';

part 'forgot_password_controller.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreen();
}

class _ForgotPasswordScreen extends ForgotPasswordController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      Text(
                          AppLocalizations.of(context)!
                              .forgotPasswordScreenTitle,
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
                                  TextFormField(
                                    enableSuggestions: false,
                                    autocorrect: false,
                                    decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context)!
                                          .sendEmailButtonLabel,
                                      hintText: AppLocalizations.of(context)!
                                          .sendEmailButtonLabel,
                                      border: OutlineInputBorder(),
                                    ),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _inputEmail = newValue;
                                      });
                                    },
                                    validator: _inputEmailValidator,
                                  ),
                                  SizedBox(
                                    height: 23,
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(AppLocalizations.of(context)!
                                          .alreadyHaveAccountButtonLabel)),
                                  Spacer(),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        FilledButton(
                                            onPressed:
                                                !_userInteractsWithAllFields() ||
                                                        _formKey.currentState ==
                                                            null ||
                                                        !_formKey.currentState!
                                                            .validate()
                                                    ? null
                                                    : _submitForm,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              child: Text(
                                                  AppLocalizations.of(context)!
                                                      .recoverPasswordButtonLabel,
                                                  style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .onPrimary,
                                                      fontSize: 18)),
                                            )),
                                      ]),
                                ],
                              ))),
                    ]))));
  }
}
