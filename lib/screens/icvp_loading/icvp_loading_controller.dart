import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ips_lacpass_app/api/api_manager.dart';
import 'package:ips_lacpass_app/api/icvp_loader.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/screens/icvp_loading/icvp_loading_screen.dart';
import 'package:ips_lacpass_app/utils/error_utils.dart';
import 'package:ips_lacpass_app/widgets/snackbar.dart';

abstract class ICVPLoadingController extends State<ICVPLoadingScreen> {
  ICVPLoadingController(String icvpCode) {
    _validateAndSaveICVP(icvpCode);
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> _validateAndSaveICVP(String icvpCode) async {
    try {
      final validationData = await ApiManager.instance.validateICVP(icvpCode);
      await ICVPLoader.instance.storeICVP(icvpCode, validationData.data);
    } on Exception catch (e) {
      if (mounted) {
        if (e is DioException) {
          showUnexpectedError(context, e);
        } else {
          showTopSnackBar(
              context, AppLocalizations.of(context)!.unexpectedErrorMessage);
        }
      }
    }
    if (mounted) {
      showTopSnackBar(context, AppLocalizations.of(context)!.icvpAddedLabel,
          backgroundColor: Theme.of(context).colorScheme.primary,
          textColor: Theme.of(context).colorScheme.onPrimary);
      Navigator.popUntil(context, ModalRoute.withName("/icvp-qr/list"));
    }
  }
}
