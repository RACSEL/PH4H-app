part of 'camera_scanner_screen.dart';

abstract class CameraScannerController extends State<CameraScannerScreen> {
  MobileScannerController? scannerController;
  final TextEditingController _passcodeController =
      TextEditingController(text: "");

  bool fromVHL = true;

  @override
  void initState() {
    super.initState();
    scannerController = MobileScannerController(
        formats: [BarcodeFormat.qrCode], autoStart: true);
  }

  @override
  void dispose() {
    // print("Dispose camera scanner screen");
    _passcodeController.dispose();
    super.dispose();
    if (scannerController != null) {
      scannerController!.dispose();
    }
  }

  void detectQrTrigger(BarcodeCapture result) {
    scannerController!.pause();
    final String? code = result.barcodes.first.rawValue;

    if (code == null || code.isEmpty) {
      showTopSnackBar(context, AppLocalizations.of(context)!.invalidQrMessage);
      scannerController!.start();
      return;
    }
    if (fromVHL) {
      _showPasscodeDialog(code);
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ICVPLoadingScreen(icvpCode: code)));
    }
  }

  void _showPasscodeDialog(String vhlCode) {
    bool isPasscodeVisible = false;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext innerContext, StateSetter innerSetState) {
            return AlertDialog(
              title:
                  Text(AppLocalizations.of(innerContext)!.passcodeTitleLabel),
              content: TextField(
                controller: _passcodeController,
                keyboardType: TextInputType.text,
                obscureText: !isPasscodeVisible,
                decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(innerContext)!.passcodeInputLabel,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasscodeVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      innerSetState(() {
                        isPasscodeVisible = !isPasscodeVisible;
                      });
                    },
                  ),
                ),
              ),
              actions: <Widget>[
                FilledButton(
                  child:
                      Text(AppLocalizations.of(innerContext)!.submitPasscode),
                  onPressed: () {
                    final enteredPasscode = _passcodeController.text;

                    Navigator.of(dialogContext).pop();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IPSViewerScreen(
                          source: IpsSource.vhl,
                          vhlCode: vhlCode,
                          passcode: enteredPasscode,
                        ),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }
}
