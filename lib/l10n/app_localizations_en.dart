// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get landingPageTitlePart1 => 'Your Health\n';

  @override
  String get landingPageTitlePart2 => 'travels with you\n';

  @override
  String get landingPageTitlePart3 => 'no borders\n';

  @override
  String get landingPageTitlePart4 => 'no barriers';

  @override
  String get forgotPasswordScreenTitle => 'Forgot Password';

  @override
  String get recoverPasswordButtonLabel => 'Recover';

  @override
  String get alreadyHaveAccountButtonLabel => 'Already have account';

  @override
  String get createAccountButtonLabel => 'Create an account';

  @override
  String get emptyEmailValidation => 'Please enter your email';

  @override
  String get incorrectEmailFormatValidation => 'Invalid email format';

  @override
  String get sendEmailButtonLabel => 'Send Email';

  @override
  String get emptyIdentifierValidation => 'Please enter your identifier';

  @override
  String get invalidIdentifierFormatValidation => 'Invalid ID format';

  @override
  String get invalidPassportFormatValidation => 'Invalid passport format';

  @override
  String get emptyPasswordValidation => 'Please enter your password';

  @override
  String get invalidPasswordValidation =>
      'Password must be at least 8 characters';

  @override
  String get emptyDocumentTypeValidation => 'Please select a document type';

  @override
  String get invalidDocumentTypeValidation => 'Invalid document type';

  @override
  String get documentTypeSelectLabel => 'Document Type';

  @override
  String get documentTypeSelectHintText => 'Select Document Type';

  @override
  String get emptyCountryValidation => 'Please select a country';

  @override
  String get invalidCountryValidation => 'Invalid country';

  @override
  String get emptyFirstNameValidation => 'Please enter your first name';

  @override
  String get emptyLastNameValidation => 'Please enter your last name';

  @override
  String get emptyVerificationCodeValidation => 'Please enter your code';

  @override
  String get invalidVerificationCodeValidation => 'Invalid code';

  @override
  String get homeScreenNoDataPlaceholder =>
      'Get your health checkups and store your information here';

  @override
  String get loadDataButtonLabel => 'Load from health provider';

  @override
  String get scanQRCodeButtonLabel => 'Scan QR Code';

  @override
  String get documentTypePassport => 'Passport';

  @override
  String get documentTypeIdentifier => 'National ID';

  @override
  String get createAccountScreenTitle => 'Create Account';

  @override
  String get countryInputLabel => 'Country';

  @override
  String get identifierInputLabel => 'Identifier';

  @override
  String get firstNameInputLabel => 'First Name';

  @override
  String get lastNameInputLabel => 'Last Name';

  @override
  String get emailInputLabel => 'Email';

  @override
  String get passwordInputLabel => 'Password';

  @override
  String get registerButtonLabel => 'Register';

  @override
  String get verifyAccountScreenTitle => 'Verify Account';

  @override
  String get verifyAccountScreenDescription =>
      'We have sent you an email to verify this account.\nPlease click the verification link to be able to login.';

  @override
  String get verificationCodeInputLabel => 'Verification Code';

  @override
  String get verifyCodeButtonLabel => 'Verify';

  @override
  String get resendEmailButtonLabel => 'Resend Email';

  @override
  String allergiesSectionTitle(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Allergies',
      one: 'Allergy',
    );
    return '$_temp0';
  }

  @override
  String get allergyStatusActive => 'Active';

  @override
  String get allergyStatusResolved => 'Resolved';

  @override
  String get allergyStatusInactive => 'Inactive';

  @override
  String conditionsSectionTitle(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Conditions',
      one: 'Condition',
    );
    return '$_temp0';
  }

  @override
  String get conditionStatusActive => 'Active';

  @override
  String get conditionStatusInactive => 'Inactive';

  @override
  String get conditionEncounterDiagnosis => 'Encounter Diagnosis';

  @override
  String immunizationSectionTitle(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Immunizations',
      one: 'Immunization',
    );
    return '$_temp0';
  }

  @override
  String get loadingIPSDataTitle => 'Loading IPS Data';

  @override
  String get loadingVHLDataTitle => 'Loading QR';

  @override
  String get shareDataButtonLabel => 'Share';

  @override
  String medicationsSectionTitle(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Medications',
      one: 'Medication',
    );
    return '$_temp0';
  }

  @override
  String get emptyRepeatPasswordValidation => 'Please confirm your password';

  @override
  String get invalidRepeatPasswordValidation => 'Passwords do not match';

  @override
  String get acceptTermsAndConditionsValidation =>
      'Please accept the terms and conditions';

  @override
  String get loginScreenTitle => 'Login';

  @override
  String get forgotPasswordLinkLabel => 'Forgot password?';

  @override
  String get loginButtonLabel => 'Login';

  @override
  String get repeatPasswordInputLabel => 'Repeat Password';

  @override
  String get acceptTermsAndConditionsLabel =>
      'I accept the terms and conditions';

  @override
  String get settingsScreenTitle => 'Settings';

  @override
  String get accountSettingsLabel => 'Account Settings';

  @override
  String get systemDefault => 'System Default';

  @override
  String get languageSettingLabel => 'Language';

  @override
  String get logoutButtonLabel => 'Logout';

  @override
  String get accountSettingsScreenTitle => 'Account Details';

  @override
  String get updateButtonLabel => 'Update';

  @override
  String get userUpdatedMessage => 'User updated';

  @override
  String get shareQrCodeScreenTitle => 'QR Code Generated';

  @override
  String get shareQrCodeDescription =>
      'Share this QR code with your physician or health care provider.';

  @override
  String get shareQrCodeBackToHomeButtonLabel => 'Back to Home';

  @override
  String get resourceSelectionTitle => 'Information Shared';

  @override
  String get resourceSelectionDescription =>
      'Select all the data you want to share:';

  @override
  String get generateQrCodeButtonLabel => 'Generate QR Code';

  @override
  String get loginInvalidCredentials => 'Invalid credentials';

  @override
  String get loginVerifyEmail => 'Please verify your email';

  @override
  String get unexpectedErrorMessage => 'An unexpected error has occurred';
}
