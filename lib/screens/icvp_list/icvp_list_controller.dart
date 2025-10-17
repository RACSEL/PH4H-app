part of 'icvp_list_screen.dart';

abstract class ICVPListController extends State<ICVPListScreen> with RouteAware {

  List<dynamic> _icvps = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route != null) {
      routeObserver.subscribe(this, route as PageRoute);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    _loadICVPs();
  }

  @override
  void didPopNext() {
    _loadICVPs();
  }

  void _loadICVPs() async {
    final storedIcvp = await ICVPLoader.instance.getStoredIcvp();
    if (storedIcvp != null && storedIcvp.keys.isNotEmpty) {
      List<dynamic> newIcvps = [];
      for (var id in storedIcvp.keys) {
        if (id.contains("HC1")) { //Loose ICVP flow
          newIcvps.add({
            "isLoose": true,
            "qrData": id,
            "icvp": storedIcvp[id]
          });
        } else { //ICVP from IPS flow
          List<String> args = id.split("&");
          if (args.length == 2) { //id contains immunizationId
            newIcvps.add({
              "isLoose": false,
              "bundleId": args[0],
              "immunizationId": args[1],
              "icvp": storedIcvp[id]
            });
          } else {
            newIcvps.add({
              "isLoose": false,
              "bundleId": args[0],
              "icvp": storedIcvp[id]
            });
          }
        }
      }
      if (mounted) {
        setState(() {
          _icvps = newIcvps;
        });
      }
    }
  }

  List<Widget> _buildICVPTileBody(dynamic icvp) {
    dynamic stats = icvp["icvp"]["payload"]?["-260"]?["-6"]?["v"];
    if (stats == null) {
      return [];
    }
    List<Widget> fields = [];
    if (icvp["icvp"]["payload"]?["-260"]?["-6"]?["ntl"] != null) {
      fields.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.countryInputLabel),
              Text(icvp["icvp"]["payload"]?["-260"]?["-6"]?["ntl"])
            ],
          )
      );
    }
    if (stats["dt"] != null) {
      fields.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context)!.issueDateLabel),
            Text(stats["dt"])
          ],
        )
      );
    }
    if (stats["dt"] != null) {
      fields.add(
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.expirationDateLabel),
              Text(stats["dt"])
            ],
          )
      );
    }

    return fields;
  }
}
