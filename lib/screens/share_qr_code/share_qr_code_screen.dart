import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/models/ips_model.dart';
import 'package:ips_lacpass_app/screens/ips_viewer/ips_viewer_screen.dart';
import 'package:ips_lacpass_app/widgets/patient_appbar/patient_appbar_widget.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ShareQrCodeScreen extends ConsumerWidget {
  const ShareQrCodeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final qrCodeContent = ref.watch(ipsModelProvider.select((ips) => ips.vhl));
    return Scaffold(
      appBar: PatientAppBar(goBackCallback: () {
        ref.read(ipsModelProvider.notifier).clearVhl();
      }),
      body: SafeArea(
        child: qrCodeContent == null ?
        SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.fromLTRB(36, 10, 36, 36),
                child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      AppLocalizations.of(context)!
                          .loadingVHLDataTitle,
                      style: TextStyle(fontSize: 36)),
                  SizedBox(
                    height: 32,
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        constraints: BoxConstraints(
                            minHeight: 48, minWidth: 48),
                      ))
                ])
            )
        ) :
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 17, 32, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  Text(AppLocalizations.of(context)!.shareQrCodeScreenTitle,
                      style: Theme.of(context).textTheme.headlineSmall),
                  const SizedBox(height: 32),
                  Text(AppLocalizations.of(context)!.shareQrCodeDescription,
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 12),
                  QrImageView(
                    data: qrCodeContent,
                    version: QrVersions.auto,
                  ),
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
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (context) => IPSViewerScreen(source: IpsSource.national),
                          ),
                          (Route<dynamic> route) => false,
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                            AppLocalizations.of(context)!
                                .shareQrCodeBackToHomeButtonLabel,
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.onSurface,
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
