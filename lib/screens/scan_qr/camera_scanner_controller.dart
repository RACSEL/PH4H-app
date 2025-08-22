part of 'camera_scanner_screen.dart';

abstract class CameraScannerController extends State<CameraScannerScreen> {
  MobileScannerController? scannerController;

  @override
  void initState() {
    super.initState();
    scannerController = MobileScannerController(
        formats: [BarcodeFormat.qrCode], autoStart: true);
  }

  @override
  void dispose() {
    print("Dispose camera scanner screen");
    super.dispose();
    if (scannerController != null) {
      scannerController!.dispose();
    }
  }

  void detectQrTrigger(BarcodeCapture result) {
    scannerController!.pause();
    final String? code = result.barcodes.first.rawValue;
    //TODO: should we check if the code has valid format?
    if (code == null || code.isEmpty) {
      showTopSnackBar(context, AppLocalizations.of(context)!.invalidQrMessage);
      scannerController!.start();
      return;
    }
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => IPSViewerScreen(
            source: IpsSource.vhl,
            vhlCode: code,
          ),
        ),
        (route) => false);
  }
}
