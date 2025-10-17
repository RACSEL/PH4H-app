import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/widgets/snackbar.dart';

void showUnexpectedError(
  BuildContext context,
  DioException error,
) {
  final errorData = error.response?.data;
  String? extractedMessage;

  if (errorData is List && errorData.isNotEmpty) {
    final firstError = errorData[0];
    if (firstError is Map<String, dynamic>) {
      extractedMessage = firstError['error_description'] as String? ??
          firstError['message'] as String?;
    }
  } else if (errorData is Map<String, dynamic>) {
    extractedMessage = errorData['message'] as String? ??
        errorData['error_description'] as String?;
  }

  showTopSnackBar(
    context,
    "${AppLocalizations.of(context)!.unexpectedErrorMessage}${extractedMessage != null ? ":\n$extractedMessage" : ''}",
  );
}
