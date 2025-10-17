import 'package:flutter/material.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/models/ips_model.dart';
import 'package:ips_lacpass_app/screens/icvp_loading/icvp_loading_screen.dart';
import 'package:ips_lacpass_app/screens/ips_viewer/ips_viewer_screen.dart';
import 'package:ips_lacpass_app/widgets/snackbar.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

part 'camera_scanner_controller.dart';

class CameraScannerScreenArguments {
  final bool fromVHL;

  const CameraScannerScreenArguments({required this.fromVHL});
}

class CameraScannerScreen extends StatefulWidget {
  const CameraScannerScreen({super.key});

  @override
  State<CameraScannerScreen> createState() => _CameraScannerScreen();
}

class _CameraScannerScreen extends CameraScannerController {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as CameraScannerScreenArguments;
    setState(() {
      fromVHL = args.fromVHL;
    });

    final size = MediaQuery.sizeOf(context);
    const double scanAreaSize = 300.0; //400x400 pixels scan area

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Stack(children: [
        MobileScanner(
          controller: scannerController,
          scanWindow: Rect.fromCenter(
              center: Offset(size.width / 2, size.height / 2),
              width: scanAreaSize,
              height: scanAreaSize),
          onDetect: detectQrTrigger,
        ),
        Center(
            child: Container(
                width: scanAreaSize,
                height: scanAreaSize,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white, width: 2.0),
                  borderRadius: BorderRadius.circular(10.0),
                )))
      ]),
    );
  }
}
