part of 'icvp_qr_screen.dart';

abstract class ICVPQRController extends State<ICVPQRScreen> {
  String? icvpQrContent;
  dynamic icvpPayload;
  bool isLoading = false;
  bool isRecreatingICVP = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> getICVP(String bundleId, String? immunizationId,
      {bool reload = false}) async {
    if (isRecreatingICVP) return;

    String id = bundleId;
    if (immunizationId != null) {
      id = "$bundleId&$immunizationId";
    }

    try {
      if (mounted) {
        setState(() {
          isRecreatingICVP = true;
        });
      }
      if (await ICVPLoader.instance.isStored() && !reload) {
        final storedIcvp = await ICVPLoader.instance.getStoredIcvp();
        String id =
            immunizationId != null ? '$bundleId&$immunizationId' : bundleId;
        if (storedIcvp != null && storedIcvp.containsKey(id)) {
          if (mounted) {
            setState(() {
              icvpQrContent = storedIcvp[id]["data"];
              icvpPayload = storedIcvp[id]["payload"];
              isRecreatingICVP = false;
            });
          }
          return;
        }
      }

      final qrData = await ApiManager.instance
          .vaccinationCertificate(bundleId, immunizationId);
      if (qrData.data != null && qrData.data["data"] != "") {
        await ICVPLoader.instance.storeICVP(id, qrData.data);
        if (mounted) {
          setState(() {
            icvpQrContent = qrData.data["data"];
            icvpPayload = qrData.data["payload"];
            isRecreatingICVP = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            isRecreatingICVP = false;
          });
        }
        throw Exception("ICVP data cannot be empty");
      }
    } catch (e) {
      if (mounted) {
        if (e is DioException) {
          showUnexpectedError(context, e);
        } else {
          showTopSnackBar(
              context, AppLocalizations.of(context)!.unexpectedErrorMessage);
        }
        Navigator.of(context).pop();
      }
    }
  }

  Future<void> getWalletLink() async {
    if (isLoading) return;
    if (mounted) {
      setState(() => isLoading = true);
    }

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
