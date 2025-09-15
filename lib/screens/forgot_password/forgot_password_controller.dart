part of 'forgot_password_screen.dart';

abstract class ForgotPasswordController
    extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _userInteractsWithAllFields() => _inputEmail != null;

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

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState!.save();
    ref.read(authStateProvider.notifier).recoverPassword().onError((err, st) {
      if (err is DioException) {
        if (err.response?.statusCode == 401) {
          if (mounted) {
            showTopSnackBar(
              context,
              AppLocalizations.of(context)!.incorrectEmailFormatValidation,
            );
          }
        } else if (err.response?.statusCode == 400) {
          if (mounted) {
            showTopSnackBar(
              context,
              AppLocalizations.of(context)!.incorrectEmailFormatValidation,
            );
          }
        }
      }
    });
  }
}
