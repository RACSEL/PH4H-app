part of 'ips_viewer_screen.dart';

abstract class IPSViewerController extends ConsumerState<IPSViewerScreen> {
  late ChangeNotifierProvider<IPSModel> ipsProvider;
  IpsSource source;
  String? vhlCode;
  bool _initialized = false;
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
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    if (!_initialized) {
      final user = ref.read(userModelProvider);

      if (user != null) {
        try {
          switch (source) {
            case IpsSource.national:
              await ref.read(ipsProvider).initState();
              break;
            case IpsSource.vhl:
              print("Loading VHL state");
              await ref.read(ipsProvider).initStateWithVhlCode(vhlCode!);
          }
          _initialized = true;

          if (mounted) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        } catch (e) {
          if (kDebugMode) {
            debugPrint('Error initiallizing IPS: $e');
          }
          if (mounted) {
            showTopSnackBar(context, AppLocalizations.of(context)!.ipsLoadErrorMessage);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ));
          }
        } finally {
          _loading = false;
        }
      }
    }
  }
}
