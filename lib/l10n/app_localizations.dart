import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @landingPageTitlePart1.
  ///
  /// In en, this message translates to:
  /// **'Your Health\n'**
  String get landingPageTitlePart1;

  /// No description provided for @landingPageTitlePart2.
  ///
  /// In en, this message translates to:
  /// **'travels with you\n'**
  String get landingPageTitlePart2;

  /// No description provided for @landingPageTitlePart3.
  ///
  /// In en, this message translates to:
  /// **'no borders\n'**
  String get landingPageTitlePart3;

  /// No description provided for @landingPageTitlePart4.
  ///
  /// In en, this message translates to:
  /// **'no barriers'**
  String get landingPageTitlePart4;

  /// No description provided for @forgotPasswordScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordScreenTitle;

  /// No description provided for @recoverPasswordButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Recover'**
  String get recoverPasswordButtonLabel;

  /// No description provided for @alreadyHaveAccountButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Already have account'**
  String get alreadyHaveAccountButtonLabel;

  /// No description provided for @createAccountButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Create an account'**
  String get createAccountButtonLabel;

  /// No description provided for @emptyEmailValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get emptyEmailValidation;

  /// No description provided for @incorrectEmailFormatValidation.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get incorrectEmailFormatValidation;

  /// No description provided for @sendEmailButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Send Email'**
  String get sendEmailButtonLabel;

  /// No description provided for @emptyIdentifierValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter your identifier'**
  String get emptyIdentifierValidation;

  /// No description provided for @invalidIdentifierFormatValidation.
  ///
  /// In en, this message translates to:
  /// **'Invalid ID format'**
  String get invalidIdentifierFormatValidation;

  /// No description provided for @invalidPassportFormatValidation.
  ///
  /// In en, this message translates to:
  /// **'Invalid passport format'**
  String get invalidPassportFormatValidation;

  /// No description provided for @emptyPasswordValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get emptyPasswordValidation;

  /// No description provided for @invalidPasswordValidation.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get invalidPasswordValidation;

  /// No description provided for @emptyDocumentTypeValidation.
  ///
  /// In en, this message translates to:
  /// **'Please select a document type'**
  String get emptyDocumentTypeValidation;

  /// No description provided for @invalidDocumentTypeValidation.
  ///
  /// In en, this message translates to:
  /// **'Invalid document type'**
  String get invalidDocumentTypeValidation;

  /// No description provided for @documentTypeSelectLabel.
  ///
  /// In en, this message translates to:
  /// **'Document Type'**
  String get documentTypeSelectLabel;

  /// No description provided for @documentTypeSelectHintText.
  ///
  /// In en, this message translates to:
  /// **'Select Document Type'**
  String get documentTypeSelectHintText;

  /// No description provided for @emptyCountryValidation.
  ///
  /// In en, this message translates to:
  /// **'Please select a country'**
  String get emptyCountryValidation;

  /// No description provided for @invalidCountryValidation.
  ///
  /// In en, this message translates to:
  /// **'Invalid country'**
  String get invalidCountryValidation;

  /// No description provided for @emptyFirstNameValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter your first name'**
  String get emptyFirstNameValidation;

  /// No description provided for @emptyLastNameValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter your last name'**
  String get emptyLastNameValidation;

  /// No description provided for @emptyVerificationCodeValidation.
  ///
  /// In en, this message translates to:
  /// **'Please enter your code'**
  String get emptyVerificationCodeValidation;

  /// No description provided for @invalidVerificationCodeValidation.
  ///
  /// In en, this message translates to:
  /// **'Invalid code'**
  String get invalidVerificationCodeValidation;

  /// No description provided for @homeScreenNoDataPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Get your health checkups and store your information here'**
  String get homeScreenNoDataPlaceholder;

  /// No description provided for @loadDataButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Load from health provider'**
  String get loadDataButtonLabel;

  /// No description provided for @scanQRCodeButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get scanQRCodeButtonLabel;

  /// No description provided for @documentTypePassport.
  ///
  /// In en, this message translates to:
  /// **'Passport'**
  String get documentTypePassport;

  /// No description provided for @documentTypeIdentifier.
  ///
  /// In en, this message translates to:
  /// **'National ID'**
  String get documentTypeIdentifier;

  /// No description provided for @createAccountScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccountScreenTitle;

  /// No description provided for @countryInputLabel.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get countryInputLabel;

  /// No description provided for @identifierInputLabel.
  ///
  /// In en, this message translates to:
  /// **'Identifier'**
  String get identifierInputLabel;

  /// No description provided for @firstNameInputLabel.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstNameInputLabel;

  /// No description provided for @lastNameInputLabel.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastNameInputLabel;

  /// No description provided for @emailInputLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailInputLabel;

  /// No description provided for @passwordInputLabel.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordInputLabel;

  /// No description provided for @registerButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerButtonLabel;

  /// No description provided for @verifyAccountScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify Account'**
  String get verifyAccountScreenTitle;

  /// No description provided for @verifyAccountScreenDescription.
  ///
  /// In en, this message translates to:
  /// **'We have sent you an email to verify this account.\nPlease click the verification link to be able to login.'**
  String get verifyAccountScreenDescription;

  /// No description provided for @verificationCodeInputLabel.
  ///
  /// In en, this message translates to:
  /// **'Verification Code'**
  String get verificationCodeInputLabel;

  /// No description provided for @verifyCodeButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verifyCodeButtonLabel;

  /// No description provided for @resendEmailButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Resend Email'**
  String get resendEmailButtonLabel;

  /// No description provided for @allergiesSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Allergy} other{Allergies}}'**
  String allergiesSectionTitle(num count);

  /// No description provided for @allergyStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get allergyStatusActive;

  /// No description provided for @allergyStatusResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get allergyStatusResolved;

  /// No description provided for @allergyStatusInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get allergyStatusInactive;

  /// No description provided for @conditionsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Condition} other{Conditions}}'**
  String conditionsSectionTitle(num count);

  /// No description provided for @conditionStatusActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get conditionStatusActive;

  /// No description provided for @conditionStatusInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get conditionStatusInactive;

  /// No description provided for @conditionEncounterDiagnosis.
  ///
  /// In en, this message translates to:
  /// **'Encounter Diagnosis'**
  String get conditionEncounterDiagnosis;

  /// No description provided for @immunizationSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Immunization} other{Immunizations}}'**
  String immunizationSectionTitle(num count);

  /// No description provided for @loadingIPSDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Loading IPS Data'**
  String get loadingIPSDataTitle;

  /// No description provided for @loadingVHLDataTitle.
  ///
  /// In en, this message translates to:
  /// **'Loading QR'**
  String get loadingVHLDataTitle;

  /// No description provided for @shareDataButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareDataButtonLabel;

  /// No description provided for @medicationsSectionTitle.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{Medication} other{Medications}}'**
  String medicationsSectionTitle(num count);

  /// No description provided for @emptyRepeatPasswordValidation.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get emptyRepeatPasswordValidation;

  /// No description provided for @invalidRepeatPasswordValidation.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get invalidRepeatPasswordValidation;

  /// No description provided for @acceptTermsAndConditionsValidation.
  ///
  /// In en, this message translates to:
  /// **'Please accept the terms and conditions'**
  String get acceptTermsAndConditionsValidation;

  /// No description provided for @loginScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginScreenTitle;

  /// No description provided for @forgotPasswordLinkLabel.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPasswordLinkLabel;

  /// No description provided for @loginButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButtonLabel;

  /// No description provided for @repeatPasswordInputLabel.
  ///
  /// In en, this message translates to:
  /// **'Repeat Password'**
  String get repeatPasswordInputLabel;

  /// No description provided for @acceptTermsAndConditionsLabel.
  ///
  /// In en, this message translates to:
  /// **'I accept the terms and conditions'**
  String get acceptTermsAndConditionsLabel;

  /// No description provided for @settingsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsScreenTitle;

  /// No description provided for @accountSettingsLabel.
  ///
  /// In en, this message translates to:
  /// **'Account Settings'**
  String get accountSettingsLabel;

  /// No description provided for @systemDefault.
  ///
  /// In en, this message translates to:
  /// **'System Default'**
  String get systemDefault;

  /// No description provided for @languageSettingLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageSettingLabel;

  /// No description provided for @logoutButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutButtonLabel;

  /// No description provided for @accountSettingsScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Account Details'**
  String get accountSettingsScreenTitle;

  /// No description provided for @updateButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get updateButtonLabel;

  /// No description provided for @userUpdatedMessage.
  ///
  /// In en, this message translates to:
  /// **'User updated'**
  String get userUpdatedMessage;

  /// No description provided for @shareQrCodeScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'QR Code Generated'**
  String get shareQrCodeScreenTitle;

  /// No description provided for @shareQrCodeDescription.
  ///
  /// In en, this message translates to:
  /// **'Share this QR code with your physician or health care provider.'**
  String get shareQrCodeDescription;

  /// No description provided for @shareQrCodeBackToHomeButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Back to Home'**
  String get shareQrCodeBackToHomeButtonLabel;

  /// No description provided for @resourceSelectionTitle.
  ///
  /// In en, this message translates to:
  /// **'Information Shared'**
  String get resourceSelectionTitle;

  /// No description provided for @resourceSelectionDescription.
  ///
  /// In en, this message translates to:
  /// **'Select all the data you want to share:'**
  String get resourceSelectionDescription;

  /// No description provided for @generateQrCodeButtonLabel.
  ///
  /// In en, this message translates to:
  /// **'Generate QR Code'**
  String get generateQrCodeButtonLabel;

  /// No description provided for @loginInvalidCredentials.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials'**
  String get loginInvalidCredentials;

  /// No description provided for @loginVerifyEmail.
  ///
  /// In en, this message translates to:
  /// **'Please verify your email'**
  String get loginVerifyEmail;

  /// No description provided for @unexpectedErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error has occurred'**
  String get unexpectedErrorMessage;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @invalidQrMessage.
  ///
  /// In en, this message translates to:
  /// **'Invalid QR. Please try again.'**
  String get invalidQrMessage;

  /// No description provided for @ipsLoadErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Error loading IPS data. Please try again.'**
  String get ipsLoadErrorMessage;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
