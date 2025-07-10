part of 'login_screen.dart';

abstract class LoginController extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedDocumentType;
  String? _inputPassword;
  late TextEditingController _passwordController;

  bool _submitting = false;

  bool _userInteractsWithAllFields() =>
      _inputId != null &&
      _inputPassword != null &&
      _selectedDocumentType != null &&
      _selectedCountryCode != null;

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

  @override
  void initState() {
    super.initState();
    _idController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _idController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    setState(() {
      _submitting = true;
    });
    if (!_formKey.currentState!.validate()) {
      setState(() {
        _submitting = false;
      });
      return;
    }
    _formKey.currentState!.save();
    ref
        .read(authStateProvider.notifier)
        .login(_inputId!, _inputPassword!)
        .then((value) {
      setState(() {
        _submitting = false;
      });
      if (mounted) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          '/home',
          (Route<dynamic> route) => false,
        );
      }
    }).onError((err, st) {
      setState(() {
        _submitting = false;
      });
      if (err is DioException) {
        if (err.response?.statusCode == 401) {
          if (mounted) {
            showTopSnackBar(
              context,
              AppLocalizations.of(context)!.loginInvalidCredentials,
            );
          }
        } else if (err.response?.statusCode == 400 &&
            err.response?.data['error_description'] ==
                'Account is not fully set up') {
          if (mounted) {
            showTopSnackBar(
              context,
              AppLocalizations.of(context)!.loginVerifyEmail,
            );
          }
        }
      }
    });
  }
}
