part of 'loose_icvp_qr_screen.dart';

abstract class LooseICVPQRController extends State<LooseICVPQRScreen> {
  String? icvpQrContent;
  dynamic icvpPayload;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getICVP(String id) async {

    try {
      // Load data if cached.
      if (await ICVPLoader.instance.isStored()) {
        final storedIcvp = await ICVPLoader.instance.getStoredIcvp();
        if (storedIcvp != null && storedIcvp.containsKey(id)) {
          setState(() {
            icvpQrContent = id;
            icvpPayload = storedIcvp[id];
          });
          return;
        }
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
