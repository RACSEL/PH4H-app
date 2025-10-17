import 'package:flutter/material.dart';
import 'package:ips_lacpass_app/api/icvp_loader.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/screens/icvp_qr/icvp_qr_screen.dart';
import 'package:ips_lacpass_app/screens/scan_qr/camera_scanner_screen.dart';
import 'package:ips_lacpass_app/screens/single_icvp_qr/loose_icvp_qr_screen.dart';
import 'package:ips_lacpass_app/utils/route_observer.dart';
import 'package:ips_lacpass_app/widgets/patient_appbar/patient_appbar_widget.dart';

part 'icvp_list_controller.dart';

class ICVPListScreen extends StatefulWidget {
  const ICVPListScreen({super.key});

  @override
  State<ICVPListScreen> createState() => _ICVPListScreen();
}

class _ICVPListScreen extends ICVPListController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PatientAppBar(),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(36, 10, 36, 36),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(AppLocalizations.of(context)!.icvpListTitle,
                      style: TextStyle(fontSize: 24)),
                  SizedBox(
                    height: 23,
                  ),
                  _icvps.isNotEmpty ? Expanded(
                      child: CustomScrollView(slivers: [
                    SliverFillRemaining(
                        hasScrollBody: true,
                        child: ListView(children: <Widget>[
                          ..._icvps.map((icvp) => Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
                              child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(6)),
                                  side: BorderSide(
                                    color: Colors.grey,
                              )),
                              title: Text(
                                  icvp["icvp"]["payload"]["-260"]["-6"]["v"]["vp"],
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 2.0, vertical: 8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          flex: 4,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: _buildICVPTileBody(icvp),
                                          )),
                                      Expanded(
                                          flex: 1,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              Icon(
                                                Icons.qr_code_2,
                                                size: 30,
                                              ),
                                            ],
                                          ))
                                    ],
                                  )),
                                onTap: () => {
                                  if (icvp["isLoose"]) {
                                    Navigator.pushNamed(context, "/loose-icvp-qr",
                                        arguments: LooseICVPQRScreenArguments(
                                            icvpData: icvp["qrData"]
                                        ))
                                  } else {
                                    if (icvp["immunizationId"] != null) {
                                      Navigator.pushNamed(context, "/icvp-qr",
                                          arguments: ICVPQRScreenArguments(
                                              bundleId: icvp["bundleId"],
                                              immunizationId: icvp["immunizationId"]
                                          ))
                                    } else {
                                      Navigator.pushNamed(context, "/icvp-qr",
                                          arguments: ICVPQRScreenArguments(
                                              bundleId: icvp["bundleId"]
                                          ))
                                    }
                                  }
                                },
                              )
                          ))
                        ]))
                  ])) : Expanded(child: Text(AppLocalizations.of(context)!.noICVPFoundLabel, style: TextStyle(fontSize: 20)),),
                  SizedBox(
                    height: 15
                  ),
                  FilledButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context,
                            "/scan-qr",
                            arguments: CameraScannerScreenArguments(fromVHL: false)
                        );
                      },
                      child: Text(AppLocalizations.of(context)!.addNewICVPButtonLabel))
                ])));
  }
}
