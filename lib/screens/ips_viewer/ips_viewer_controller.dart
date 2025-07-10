part of 'ips_viewer_screen.dart';

abstract class IPSViewerController extends ConsumerState<IPSViewerScreen> {
  bool _initialized = false;
  bool _loading = true;

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();

    if (!_initialized) {
      final user = ref.read(userModelProvider);

      if (user != null) {
        try {
          await ref.read(ipsModelProvider).initState();
          _initialized = true;

          if (mounted) {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }
        } catch (e) {
          if (kDebugMode) {
            debugPrint('Error initiallizing IPS: $e');
          }
          if (mounted) {
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
