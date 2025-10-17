part of 'ips_viewer_screen.dart';

abstract class IPSViewerController extends ConsumerState<IPSViewerScreen> {
  late ChangeNotifierProvider<IPSModel> ipsProvider;
  IpsSource source;
  String? vhlCode;
  String? passcode;
  bool _loading = true;

  IPSViewerController({required this.source, this.vhlCode, this.passcode}) {
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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final user = ref.read(userModelProvider);
      if (user != null) {
        switch (source) {
          case IpsSource.national:
            ref.read(ipsProvider).initState().then((resp) {
              if (mounted) {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            }).onError((error, stackTrace) {
              debugPrint('Error initiallizing National IPS');

              if (mounted) {
                if (error is DioException) {
                  showUnexpectedError(context, error);
                } else {
                  showTopSnackBar(context,
                      AppLocalizations.of(context)!.ipsLoadErrorMessage);
                }
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ));
              }
            }).whenComplete(() {
              _loading = false;
            });
            break;
          case IpsSource.vhl:
            if (passcode == null || passcode!.isEmpty) {
              showTopSnackBar(context,
                  AppLocalizations.of(context)!.ipsLoadErrorMessage);
              Navigator.pop(context);
              return;
            }
            ref
                .read(ipsProvider)
                .initStateWithVhlCode(vhlCode!, passcode!)
                .then((resp) {
              if (mounted) {
                Navigator.of(context).popUntil((route) => route.isFirst);
              }
            }).onError((error, stackTrace) {
              debugPrint(error.toString());
              debugPrint('Error initiallizing VHL IPS');
              if (mounted) {
                if (error is DioException) {
                  showUnexpectedError(context, error);
                } else {
                  showTopSnackBar(context,
                      AppLocalizations.of(context)!.ipsLoadErrorMessage);
                }
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
            }).whenComplete(() {
              _loading = false;
            });
        }
      }
    });
  }
}
