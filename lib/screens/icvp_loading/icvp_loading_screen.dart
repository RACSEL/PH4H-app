import 'package:flutter/material.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/screens/icvp_loading/icvp_loading_controller.dart';
import 'package:ips_lacpass_app/widgets/patient_appbar/patient_appbar_widget.dart';

class ICVPLoadingScreen extends StatefulWidget {

  final String icvpCode;

  const ICVPLoadingScreen({super.key, required this.icvpCode});

  @override
  State<ICVPLoadingScreen> createState() =>_ICVPLoadingScreen(this.icvpCode);

}

class _ICVPLoadingScreen extends ICVPLoadingController {

  _ICVPLoadingScreen(super.icvpCode);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PatientAppBar(),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(36, 10, 36, 36),
            child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppLocalizations.of(context)!.loadingICVPTitle,
                              style: TextStyle(fontSize: 36)),
                          SizedBox(
                            height: 32,
                          ),
                          Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                constraints:
                                BoxConstraints(minHeight: 48, minWidth: 48),
                              ))
                        ])))));
  }
}
