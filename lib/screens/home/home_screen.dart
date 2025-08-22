import 'package:flutter/material.dart';
import 'package:ips_lacpass_app/models/ips_model.dart';
import 'package:ips_lacpass_app/screens/ips_viewer/ips_viewer_screen.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/widgets/patient_appbar/patient_appbar_widget.dart';
import 'package:ips_lacpass_app/widgets/qr_scanner_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PatientAppBar(),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 48),
            child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(36, 0, 36, 48),
                        child: Column(children: [
                          Image.asset('assets/images/insurance_logo.png',
                              width: 222, height: 108),
                          SizedBox(
                            height: 48,
                          ),
                          Text(AppLocalizations.of(context)!
                              .homeScreenNoDataPlaceholder)
                        ])),
                    SizedBox(height: 48),
                    FilledButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => IPSViewerScreen(source: IpsSource.national),
                              ));
                        },
                        child: Text(
                            AppLocalizations.of(context)!.loadDataButtonLabel)),
                    SizedBox(height: 48),
                    QRScannerButton()
                  ]),
            )));
  }
}
