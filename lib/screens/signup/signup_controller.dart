part of 'signup_screen.dart';

abstract class SignupController extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedDocumentType;

  bool _submitting = false;

  bool _userInteractsWithAllFields() =>
      _inputId != null &&
      _inputPassword != null &&
      _inputRepeatPassword != null &&
      _selectedDocumentType != null &&
      _selectedCountryCode != null &&
      _inputFirstName != null &&
      _inputLastName != null &&
      _acceptTerms == true &&
      _inputEmail != null;

  String? _inputId;
  late TextEditingController _idController;
  String? _inputIdValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.emptyIdentifierValidation;
    }
    if (_selectedDocumentType == DocumentType.dni.value) {
      if (!Constants.dniRegex.hasMatch(value)) {
        return AppLocalizations.of(context)!.invalidIdentifierFormatValidation;
      }
    } else if (_selectedDocumentType == DocumentType.passport.value) {
      if (!Constants.passportRegex.hasMatch(value)) {
        return AppLocalizations.of(context)!.invalidPassportFormatValidation;
      }
    }
    return null;
  }

  String? _inputFirstName;
  late TextEditingController _firstNameController;
  String? _inputFirstNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.emptyFirstNameValidation;
    }
    return null;
  }

  String? _inputLastName;
  late TextEditingController _lastNameController;
  String? _inputLastNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.emptyLastNameValidation;
    }
    return null;
  }

  String? _inputEmail;
  late TextEditingController _emailController;
  String? _inputEmailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.emptyEmailValidation;
    }
    if (!Constants.emailRegex.hasMatch(value)) {
      return AppLocalizations.of(context)!.incorrectEmailFormatValidation;
    }
    return null;
  }

  String? _inputPassword;
  late TextEditingController _passwordController;
  String? _passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.emptyPasswordValidation;
    }
    if (value.length < 8) {
      return AppLocalizations.of(context)!.invalidPassportFormatValidation;
    }
    return null;
  }

  String? _inputRepeatPassword;
  late TextEditingController _repeatPasswordController;
  String? _repeatPasswordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.emptyRepeatPasswordValidation;
    }
    if (value != _inputPassword) {
      return AppLocalizations.of(context)!.invalidRepeatPasswordValidation;
    }
    return null;
  }

  String? _selectedCountryCode;
  String? _countryValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.emptyCountryValidation;
    }
    if (!Constants.countryOptions.any((country) => country['value'] == value)) {
      return AppLocalizations.of(context)!.invalidCountryValidation;
    }
    return null;
  }

  bool _acceptTerms = false;
  String? _termsValidator(bool? value) {
    if (value == null || !value) {
      return AppLocalizations.of(context)!.acceptTermsAndConditionsValidation;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    _repeatPasswordController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    setState(() {
      _submitting = true;
    });
    _formKey.currentState!.save();
      ref.read(authStateProvider.notifier).register(
          _inputId!,
          _inputEmail!,
          _inputFirstName!,
          _inputLastName!,
          _inputPassword!,
          _inputRepeatPassword!,
          ref.read(localeProvider).toString(),
          _selectedDocumentType!
      ).then((_) {
        if (mounted) {
          Navigator.pushNamed(context, '/verify-account');
        }
      }).onError((err, st) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('An unexpected error has occurred',
                  style: TextStyle(color: Theme
                      .of(context)
                      .colorScheme
                      .onError)),
              duration: const Duration(seconds: 2),
              backgroundColor: Theme
                  .of(context)
                  .colorScheme
                  .error
          ));
        }
      });
    setState(() {
      _submitting = false;
    });
  }
}
