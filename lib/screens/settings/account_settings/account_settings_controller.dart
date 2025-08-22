part of 'account_settings_screen.dart';

abstract class AccountSettingsController
    extends ConsumerState<AccountSettingsScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _submitting = false;

  String? _inputFirstName;
  String? _inputLastName;
  String? _inputEmail;
  String? _identifier;

  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    parsePatientName();
  }

  Future<void> parsePatientName() async {
    User? user = ref.read(userModelProvider);
    if (user != null) {
      setState(() {
        _inputFirstName = user.firstName;
        _inputLastName = user.lastName;
        _inputEmail = user.email;
        _identifier = user.identifier;

        _firstNameController.text = user.firstName;
        _lastNameController.text = user.lastName;
      });
    }
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  bool _userInteractsWithSomeField() =>
      _inputFirstName != null || _inputLastName != null;

  String? _inputFirstNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.emptyFirstNameValidation;
    }
    return null;
  }

  String? _inputLastNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.emptyLastNameValidation;
    }
    return null;
  }

  String? _inputEmailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.emptyEmailValidation;
    }
    if (!Constants.emailRegex.hasMatch(value)) {
      return AppLocalizations.of(context)!.incorrectEmailFormatValidation;
    }
    return null;
  }

  void _submitForm() async {
    setState(() {
      _submitting = true;
    });
    _formKey.currentState!.save();
    final userId = ref.read(userModelProvider)!.identifier;
    if (userId == '') {
      showTopSnackBar(
          context, AppLocalizations.of(context)!.unexpectedErrorMessage,
          backgroundColor: Theme.of(context).colorScheme.error,
          textColor: Theme.of(context).colorScheme.onError);
      setState(() {
        _submitting = false;
      });
      assert(() {
        print("[ERROR]: userId is null");
        return true;
      }());

      return;
    }
    ref
        .read(authStateProvider.notifier)
        .updateUser(_inputFirstName!, _inputLastName!)
        .then((_) {
      if (mounted) {
        showTopSnackBar(
            context, AppLocalizations.of(context)!.userUpdatedMessage,
            backgroundColor: Theme.of(context).colorScheme.primary,
            textColor: Theme.of(context).colorScheme.onPrimary);
        setState(() {
          _inputFirstName = null;
          _inputLastName = null;
          _submitting = false;
        });
        Navigator.of(context).pop();
      }
    }).onError((err, st) {
      if (mounted) {
        showTopSnackBar(
            context, AppLocalizations.of(context)!.unexpectedErrorMessage,
            backgroundColor: Theme.of(context).colorScheme.error,
            textColor: Theme.of(context).colorScheme.onError);
        setState(() {
          _submitting = false;
        });
      }
    });
  }
}
