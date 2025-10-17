import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/l10n/locale_provider.dart';
import 'package:ips_lacpass_app/models/auth_state_notifier.dart';
import 'package:ips_lacpass_app/utils/error_utils.dart';
import 'package:ips_lacpass_app/widgets/filled_button.dart';
import 'package:ips_lacpass_app/widgets/password_form_field.dart';

import 'package:ips_lacpass_app/widgets/patient_form/document_type_select.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/constants.dart';
import 'package:ips_lacpass_app/widgets/patient_form/national_id_input.dart';
import 'package:ips_lacpass_app/widgets/snackbar.dart';

part 'signup_controller.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreen();
}

class _SignupScreen extends SignupController {
  final ScrollController _scrollController = ScrollController();
  final Map<String, FocusNode> _focusNodes = {};

  FocusNode _getFocusNode(String key) {
    return _focusNodes.putIfAbsent(key, () => FocusNode());
  }

  void _scrollToField(String key) async {
    final node = _focusNodes[key];
    if (node == null || !_scrollController.hasClients) return;

    // Wait until keyboard is fully open
    while (MediaQuery.of(context).viewInsets.bottom == 0) {
      await Future.delayed(const Duration(milliseconds: 50));
      if (!mounted) return;
    }

    if (!mounted) return;

    // Then scroll the field into view
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final context = node.context;
      if (context != null) {
        Scrollable.ensureVisible(
          context,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          alignment: 0.3,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Stack(children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(32, 17, 32, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("assets/icon/logo.png", width: 60),
              const SizedBox(height: 32),
              Text(AppLocalizations.of(context)!.createAccountScreenTitle,
                  style: TextStyle(fontSize: 36)),
              const SizedBox(height: 32),
              Expanded(child: LayoutBuilder(builder: (context, constraints) {
                final viewInsets = MediaQuery.of(context).viewInsets.bottom;
                final buttonHeight = 100;
                return SingleChildScrollView(
                  controller: _scrollController,
                  padding: EdgeInsets.only(
                      bottom:
                          viewInsets > 0 ? viewInsets + 20 : buttonHeight + 20,
                      top: 16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
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
                          focusNode: _getFocusNode('firstName'),
                          onTap: () => _scrollToField('firstName'),
                          onTapOutside: (PointerDownEvent event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          enableSuggestions: false,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!
                                .firstNameInputLabel,
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
                          focusNode: _getFocusNode('lastName'),
                          onTap: () => _scrollToField('lastName'),
                          onTapOutside: (PointerDownEvent event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          enableSuggestions: false,
                          decoration: InputDecoration(
                            labelText: AppLocalizations.of(context)!
                                .lastNameInputLabel,
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              _inputLastName = newValue;
                            });
                          },
                          validator: _inputLastNameValidator,
                        ),
                        SizedBox(height: 23),
                        TextFormField(
                          focusNode: _getFocusNode('email'),
                          onTap: () => _scrollToField('email'),
                          onTapOutside: (PointerDownEvent event) {
                            FocusManager.instance.primaryFocus?.unfocus();
                          },
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText:
                                AppLocalizations.of(context)!.emailInputLabel,
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              _inputEmail = newValue;
                            });
                          },
                          validator: _inputEmailValidator,
                        ),
                        SizedBox(height: 23),
                        PasswordFormField(
                          inputLabel:
                              AppLocalizations.of(context)!.passwordInputLabel,
                          passwordValidator: _passwordValidator,
                          onChanged: (newValue) {
                            setState(() {
                              _inputPassword = newValue;
                            });
                          },
                          onTap: () => _scrollToField('password'),
                          focusNode: _getFocusNode('password'),
                        ),
                        SizedBox(height: 23),
                        PasswordFormField(
                          inputLabel: AppLocalizations.of(context)!
                              .repeatPasswordInputLabel,
                          passwordValidator: _repeatPasswordValidator,
                          onChanged: (newValue) {
                            setState(() {
                              _inputRepeatPassword = newValue;
                            });
                          },
                          onTap: () => _scrollToField('repeatPassword'),
                          focusNode: _getFocusNode('repeatPassword'),
                        ),
                        SizedBox(height: 15),
                        FormField<bool>(
                            builder: (state) {
                              return Column(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Checkbox(
                                          value: _acceptTerms,
                                          onChanged: (value) {
                                            setState(() {
                                              _acceptTerms = value ?? false;
                                              state.didChange(value);
                                            });
                                          }),
                                      Flexible(
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .acceptTermsAndConditionsLabel,
                                          softWrap: true,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    state.errorText ?? '',
                                    style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.error,
                                    ),
                                  )
                                ],
                              );
                            },
                            validator: _termsValidator),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: 5,
                          ),
                          child: SizedBox.shrink(),
                        ),
                      ],
                    ),
                  ),
                );
              })),
            ],
          ),
        ),
        Positioned(
            left: 32,
            right: 32,
            bottom: 0,
            child: Container(
              color: Theme.of(context).colorScheme.surface,
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Ph4hFilledButton(
                      submitting: _submitting,
                      buttonLabel:
                          AppLocalizations.of(context)!.registerButtonLabel,
                      isDisabled: _submitting ||
                          !_userInteractsWithAllFields() ||
                          _formKey.currentState == null ||
                          !_formKey.currentState!.validate(),
                      onPressed: _submitForm),
                  const SizedBox(height: 10),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                          AppLocalizations.of(context)!
                              .alreadyHaveAccountButtonLabel,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurface,
                              fontSize: 18)),
                    ),
                  ),
                ],
              ),
            )),
      ])),
    );
  }
}
