part of 'forgot_password_screen.dart';

abstract class ForgotPasswordController extends State<ForgotPasswordScreen> {
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
    //TODO: implement submit forgot password form
    print('Forgot Password');
  }
}
