import 'package:flutter/material.dart';
import 'package:ips_lacpass_app/api/api_manager.dart';
import 'package:ips_lacpass_app/constants.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/models/credential_type.dart';
import 'package:ips_lacpass_app/widgets/patient_appbar/patient_appbar_widget.dart';
import 'package:ips_lacpass_app/widgets/snackbar.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

part 'icvp_qr_controller.dart';

class ICVPQRScreenArguments {
  final String bundleId;
  final String? immunizationId;

  const ICVPQRScreenArguments({required this.bundleId, this.immunizationId});
}

class ICVPQRScreen extends StatefulWidget {
  final bool loading = true;

  const ICVPQRScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ICVPScreen();
}

class _ICVPScreen extends ICVPQRController {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as ICVPQRScreenArguments;

    if (icvpQrContent == null) {
      getICVP(args.bundleId, args.immunizationId);
    }

    return Scaffold(
      appBar: PatientAppBar(),
      body: SafeArea(
        child: icvpQrContent == null
            ? SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.fromLTRB(36, 10, 36, 36),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.loadingICVPTitle,
                              style: TextStyle(fontSize: 36)),
                          SizedBox(
                            height: 32,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                constraints:
                                    BoxConstraints(minHeight: 48, minWidth: 48),
                              ))
                        ])))
            : Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(32, 17, 32, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        Text(
                            AppLocalizations.of(context)!
                                .shareIcvpQrCodeScreenTitle,
                            style: Theme.of(context).textTheme.headlineSmall),
                        const SizedBox(height: 32),
                        Text(
                            AppLocalizations.of(context)!
                                .shareQrCodeDescription,
                            style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(height: 12),
                        QrImageView(
                          data: icvpQrContent!,
                          version: QrVersions.auto,
                        ),
                        if (Constants.showWallet) const SizedBox(height: 20),
                        if (Constants.showWallet)
                          Center(
                            child: SizedBox(
                              width: 200,
                              child: FilledButton(
                                onPressed: isLoading ? () {} : getWalletLink,
                                child: isLoading
                                    ? SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                            Theme.of(context)
                                                .colorScheme
                                                .onPrimary,
                                          ),
                                        ),
                                      )
                                    : Text(
                                        AppLocalizations.of(context)!
                                            .addToWalletLabel,
                                        style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onPrimary,
                                          fontSize: 18,
                                        ),
                                      ),
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                  Positioned(
                    left: 32,
                    right: 32,
                    bottom: 0,
                    child: Container(
                      color: Theme.of(context).colorScheme.surface,
                      padding: const EdgeInsets.only(top: 16, bottom: 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              icvpQrContent = null;
                              Navigator.of(context).pop();
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                  AppLocalizations.of(context)!
                                      .shareQrCodeBackToHomeButtonLabel,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                      fontSize: 18)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
