// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get landingPageTitlePart1 => 'Tu salud\n';

  @override
  String get landingPageTitlePart2 => 'viaja contigo\n';

  @override
  String get landingPageTitlePart3 => 'sin fronteras\n';

  @override
  String get landingPageTitlePart4 => 'sin barreras';

  @override
  String get forgotPasswordScreenTitle => 'Olvidé mi contraseña';

  @override
  String get recoverPasswordButtonLabel => 'Recuperar';

  @override
  String get alreadyHaveAccountButtonLabel => 'Ya tengo una cuenta';

  @override
  String get createAccountButtonLabel => 'Crear una cuenta';

  @override
  String get emptyEmailValidation => 'Por favor, ingresa tu correo electrónico';

  @override
  String get incorrectEmailFormatValidation =>
      'Formato de correo electrónico inválido';

  @override
  String get sendEmailButtonLabel => 'Enviar correo';

  @override
  String get emptyIdentifierValidation => 'Por favor, ingresa tu identificador';

  @override
  String get invalidIdentifierFormatValidation => 'Formato de DNI inválido';

  @override
  String get invalidPassportFormatValidation => 'Formato de pasaporte inválido';

  @override
  String get emptyPasswordValidation => 'Por favor, ingresa tu contraseña';

  @override
  String get invalidPasswordValidation =>
      'La contraseña debe tener al menos 8 caracteres';

  @override
  String get emptyDocumentTypeValidation =>
      'Por favor, selecciona un tipo de documento';

  @override
  String get invalidDocumentTypeValidation => 'Tipo de documento inválido';

  @override
  String get documentTypeSelectLabel => 'Tipo de documento';

  @override
  String get documentTypeSelectHintText => 'Selecciona el tipo de documento';

  @override
  String get emptyCountryValidation => 'Por favor, selecciona un país';

  @override
  String get invalidCountryValidation => 'País inválido';

  @override
  String get emptyFirstNameValidation => 'Por favor, ingresa tu nombre';

  @override
  String get emptyLastNameValidation => 'Por favor, ingresa tu apellido';

  @override
  String get emptyVerificationCodeValidation => 'Por favor, ingresa el código';

  @override
  String get invalidVerificationCodeValidation => 'Código inválido';

  @override
  String get homeScreenNoDataPlaceholder =>
      'Hazte chequeos médicos y guarda tu información aquí';

  @override
  String get loadDataButtonLabel => 'Cargar desde proveedor de salud';

  @override
  String get scanQRCodeButtonLabel => 'Escanear código QR';

  @override
  String get documentTypePassport => 'Pasaporte';

  @override
  String get documentTypeIdentifier => 'Cédula / DNI';

  @override
  String get createAccountScreenTitle => 'Crear cuenta';

  @override
  String get countryInputLabel => 'País';

  @override
  String get identifierInputLabel => 'Identificador';

  @override
  String get firstNameInputLabel => 'Nombre';

  @override
  String get lastNameInputLabel => 'Apellido';

  @override
  String get emailInputLabel => 'Correo electrónico';

  @override
  String get passwordInputLabel => 'Contraseña';

  @override
  String get registerButtonLabel => 'Registrarse';

  @override
  String get verifyAccountScreenTitle => 'Verificar cuenta';

  @override
  String get verifyAccountScreenDescription =>
      'Te hemos enviado un correo para verificar esta cuenta.\nPor favor, apreta el link de verificación para poder iniciar su sesión.';

  @override
  String get verificationCodeInputLabel => 'Código de verificación';

  @override
  String get verifyCodeButtonLabel => 'Verificar';

  @override
  String get resendEmailButtonLabel => 'Reenviar correo';

  @override
  String allergiesSectionTitle(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Alergias',
      one: 'Alergia',
    );
    return '$_temp0';
  }

  @override
  String get allergyStatusActive => 'Activa';

  @override
  String get allergyStatusResolved => 'Resuelta';

  @override
  String get allergyStatusInactive => 'Inactiva';

  @override
  String conditionsSectionTitle(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Condiciones',
      one: 'Condición',
    );
    return '$_temp0';
  }

  @override
  String get conditionStatusActive => 'Activa';

  @override
  String get conditionStatusInactive => 'Inactiva';

  @override
  String get conditionEncounterDiagnosis => 'Diagnóstico de encuentro';

  @override
  String immunizationSectionTitle(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Vacunas',
      one: 'Vacuna',
    );
    return '$_temp0';
  }

  @override
  String get loadingIPSDataTitle => 'Cargando datos IPS';

  @override
  String get loadingVHLDataTitle => 'Cargando QR';

  @override
  String get shareDataButtonLabel => 'Compartir';

  @override
  String medicationsSectionTitle(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Medicamentos',
      one: 'Medicamento',
    );
    return '$_temp0';
  }

  @override
  String get emptyRepeatPasswordValidation =>
      'Por favor confirma tu contraseña';

  @override
  String get invalidRepeatPasswordValidation => 'Las contraseñas no coinciden';

  @override
  String get acceptTermsAndConditionsValidation =>
      'Por favor acepta los términos y condiciones';

  @override
  String get loginScreenTitle => 'Iniciar sesión';

  @override
  String get forgotPasswordLinkLabel => '¿Olvidaste tu contraseña?';

  @override
  String get loginButtonLabel => 'Iniciar sesión';

  @override
  String get repeatPasswordInputLabel => 'Repetir contraseña';

  @override
  String get acceptTermsAndConditionsLabel =>
      'Acepto los términos y condiciones';

  @override
  String get settingsScreenTitle => 'Configuraciones';

  @override
  String get accountSettingsLabel => 'Configuraciones de la cuenta';

  @override
  String get systemDefault => 'Predeterminado del sistema';

  @override
  String get languageSettingLabel => 'Idioma';

  @override
  String get logoutButtonLabel => 'Cerrar sesión';

  @override
  String get accountSettingsScreenTitle => 'Detalles de la cuenta';

  @override
  String get updateButtonLabel => 'Actualizar';

  @override
  String get userUpdatedMessage => 'Usuario actualizado';

  @override
  String get shareQrCodeScreenTitle => 'Código QR Generado';

  @override
  String get shareQrCodeDescription =>
      'Comparte este código QR con tu médico o proveedor de atención médica.';

  @override
  String get shareQrCodeBackToHomeButtonLabel => 'Volver al inicio';

  @override
  String get resourceSelectionTitle => 'Información compartida';

  @override
  String get resourceSelectionDescription =>
      'Selecciona todos los datos que deseas compartir:';

  @override
  String get generateQrCodeButtonLabel => 'Generar código QR';

  @override
  String get loginInvalidCredentials => 'Credenciales inválidas';

  @override
  String get loginVerifyEmail => 'Por favor verifica tu correo electrónico';

  @override
  String get unexpectedErrorMessage => 'Un error inesperado ha ocurrido';
}
