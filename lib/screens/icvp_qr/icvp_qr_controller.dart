part of 'icvp_qr_screen.dart';

abstract class ICVPQRController extends State<ICVPQRScreen> {
  String? icvpQrContent;
  dynamic icvpPayload;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getICVP(String bundleId, String? immunizationId) async {
    try {
      final qrData = await ApiManager.instance
          .vaccinationCertificate(bundleId, immunizationId);
      if (qrData.data != null && qrData.data["data"] != "") {
        setState(() {
          icvpQrContent = qrData.data["data"];
        });
      } else {
        throw Exception("ICVP data cannot be empty");
      }
    } catch (e, st) {
      debugPrintStack(stackTrace: st);
      debugPrint(e.toString());
      if (mounted) {
        showTopSnackBar(
            context, AppLocalizations.of(context)!.unexpectedErrorMessage);
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> getWalletLink() async {
    if (isLoading) return;
    setState(() => isLoading = true);

    try {
      final walletUrl = await ApiManager.instance
          .getWalletUrl(icvpPayload, CredentialType.icvp);

      if (walletUrl.data != null && walletUrl.data["coUrl"] != "") {
        var url = walletUrl.data["coUrl"];
        if (!await launchUrl(Uri.parse(url))) {
          throw Exception('Could not launch $url');
        }
      } else {
        throw Exception("Wallet data returned empty");
      }
    } catch (e, st) {
      debugPrintStack(stackTrace: st);
      debugPrint(e.toString());
      if (mounted) {
        showTopSnackBar(
            context, AppLocalizations.of(context)!.unexpectedErrorMessage);
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }
}
