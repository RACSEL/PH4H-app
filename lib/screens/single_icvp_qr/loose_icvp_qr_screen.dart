import 'package:flutter/material.dart';
import 'package:ips_lacpass_app/api/api_manager.dart';
import 'package:ips_lacpass_app/api/icvp_loader.dart';
import 'package:ips_lacpass_app/constants.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/models/credential_type.dart';
import 'package:ips_lacpass_app/widgets/patient_appbar/patient_appbar_widget.dart';
import 'package:ips_lacpass_app/widgets/snackbar.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

part 'loose_icvp_qr_controller.dart';

// "Loose" ICVP means an ICVP that is not linked to the user's IPS.
class LooseICVPQRScreenArguments {
  final String icvpData; //We use the icvp QR Data as the ID in the storage

  const LooseICVPQRScreenArguments({required this.icvpData});
}

class LooseICVPQRScreen extends StatefulWidget {
  final bool loading = true;

  const LooseICVPQRScreen({super.key});

  @override
  State<StatefulWidget> createState() => _LooseICVPScreen();
}

class _LooseICVPScreen extends LooseICVPQRController {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as LooseICVPQRScreenArguments;

    if (icvpQrContent == null) {
      getICVP(args.icvpData);
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
                        const SizedBox(height: 16),
                        Text(
                            AppLocalizations.of(context)!
                                .shareQrCodeDescription,
                            style: Theme.of(context).textTheme.bodyMedium),
                        const SizedBox(height: 8),
                        QrImageView(
                          data: icvpQrContent!,
                          version: QrVersions.auto,
                        ),
                        const SizedBox(height: 8),
                        if (Constants.showWallet) ...[
                          const SizedBox(height: 8),
                          Center(
                            child: SizedBox(
                              width: 230,
                              child: FilledButton(
                                onPressed: isLoading
                                    ? null
                                    : getWalletLink,
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
                          ),
                        ],
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
                              Navigator.popUntil(context, ModalRoute.withName("/ips"));
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
