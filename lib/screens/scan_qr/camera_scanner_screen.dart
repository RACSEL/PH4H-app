import 'package:flutter/material.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/models/ips_model.dart';
import 'package:ips_lacpass_app/screens/ips_viewer/ips_viewer_screen.dart';
import 'package:ips_lacpass_app/widgets/snackbar.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

part 'camera_scanner_controller.dart';

class CameraScannerScreen extends StatefulWidget {

  const CameraScannerScreen({super.key});

  @override
  State<CameraScannerScreen> createState() => _CameraScannerScreen();
}

class _CameraScannerScreen extends CameraScannerController {

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    const double scanAreaSize = 300.0; //400x400 pixels scan area

    return Scaffold(
        body: Stack(children: [
      MobileScanner(
        controller: scannerController,
        scanWindow: Rect.fromCenter(
            center: Offset(size.width / 2, size.height / 2),
            width: scanAreaSize,
            height: scanAreaSize
        ),
        onDetect: detectQrTrigger
      ),
      // Square for detection aid
      Center(
          child: Container(
              width: scanAreaSize,
              height: scanAreaSize,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 2.0),
                borderRadius: BorderRadius.circular(10.0),
              )))
    ]));
  }
}
