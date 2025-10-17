import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/models/ips_model.dart';
import 'package:ips_lacpass_app/screens/scan_qr/camera_scanner_screen.dart';

class QRScannerButton extends ConsumerWidget {
  const QRScannerButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ipsNotLoaded = !ref.watch(ipsModelProvider.select((ips) => ips.isInStorage));
    return FilledButton(
        onPressed: ipsNotLoaded
            ? null
            : () {
          Navigator.pushNamed(
              context,
              "/scan-qr",
              arguments: CameraScannerScreenArguments(fromVHL: true)
          );
              },
        child: Text(AppLocalizations.of(context)!.scanQRCodeButtonLabel));
  }
}
