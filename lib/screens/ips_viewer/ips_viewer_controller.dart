part of 'ips_viewer_screen.dart';

abstract class IPSViewerController extends ConsumerState<IPSViewerScreen> {
  late ChangeNotifierProvider<IPSModel> ipsProvider;
  IpsSource source;
  String? vhlCode;
  bool _loading = true;

  IPSViewerController({required this.source, this.vhlCode}) {
    switch (source) {
      case IpsSource.national:
        ipsProvider = ipsModelProvider;
        break;
      case IpsSource.vhl:
        ipsProvider = ipsVhlModelProvider;
    }
  }

  @override
  void initState() {
    super.initState();
    final user = ref.read(userModelProvider);
    if (user != null) {
      switch (source) {
        case IpsSource.national:
          ref.read(ipsProvider).initState().then((resp) {
            if (mounted) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
            _loading = false;
          }).onError((error, stackTrace) {
            debugPrint('Error initiallizing IPS: $error');
            if (mounted) {
              showTopSnackBar(
                  context, AppLocalizations.of(context)!.ipsLoadErrorMessage);
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ));
            }
          });
          break;
        case IpsSource.vhl:
          ref.read(ipsProvider).initStateWithVhlCode(vhlCode!).then((resp) {
            if (mounted) {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }
            _loading = false;
          }).onError((error, stackTrace) {
            if (kDebugMode) {
              debugPrint('Error initiallizing IPS: $error');
            }
            if (mounted) {
              showTopSnackBar(
                  context, AppLocalizations.of(context)!.ipsLoadErrorMessage);
              if (ref.read(ipsModelProvider).bundle == null) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
              } else {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/ips', (Route<dynamic> route) => false);
              }
            }
          });
      }
    }
  }
}
