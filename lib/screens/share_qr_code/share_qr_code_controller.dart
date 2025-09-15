part of 'share_qr_code_screen.dart';

abstract class ShareQrCodeController extends ConsumerState<ShareQrCodeScreen> {
  String? icvpQrContent;
  dynamic qrCodeContent;
  dynamic vhlPayload;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    qrCodeContent = ref.read(ipsModelProvider.select((ips) => ips.vhl));
    vhlPayload = ref.read(ipsModelProvider.select((ips) => ips.vhlPayload));
  }

  Future<void> getWalletLink() async {
    if (isLoading) return;
    setState(() => isLoading = true);

    try {
      final walletUrl = await ApiManager.instance
          .getWalletUrl(vhlPayload, CredentialType.verifiableHealthLink);

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
