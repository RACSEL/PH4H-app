import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/models/auth_state_notifier.dart';
import 'package:ips_lacpass_app/screens/home/home_screen.dart';
import 'package:ips_lacpass_app/screens/ips_resource_selection/ips_resource_selection_screen.dart';
import 'package:ips_lacpass_app/screens/ips_viewer/allergies_card.dart';
import 'package:ips_lacpass_app/screens/ips_viewer/conditions_card.dart';
import 'package:ips_lacpass_app/models/ips_model.dart';
import 'package:ips_lacpass_app/models/user_model.dart';
import 'package:ips_lacpass_app/screens/ips_viewer/immunizations_card.dart';
import 'package:ips_lacpass_app/screens/ips_viewer/medications_card.dart';
import 'package:ips_lacpass_app/widgets/patient_appbar/patient_appbar_widget.dart';

part 'ips_viewer_controller.dart';

class IPSViewerScreen extends ConsumerStatefulWidget {
  const IPSViewerScreen({super.key});

  @override
  ConsumerState<IPSViewerScreen> createState() => _IPSViewerScreen();
}

class _IPSViewerScreen extends IPSViewerController {
  @override
  Widget build(BuildContext context) {
    ref.listen(ipsModelProvider.select((ips) => ips.bundle), (previous, next) {
      if (next != null) {
        setState(() {
          _loading = false;
        });
      }
    });
    return Scaffold(
        appBar: PatientAppBar(),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(36, 10, 36, 36),
            child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: _loading
                    ? SingleChildScrollView(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                            Text(
                                AppLocalizations.of(context)!
                                    .loadingIPSDataTitle,
                                style: TextStyle(fontSize: 36)),
                            SizedBox(
                              height: 32,
                            ),
                            Align(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(
                                  constraints: BoxConstraints(
                                      minHeight: 48, minWidth: 48),
                                ))
                          ]))
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                            Expanded(
                                child: CustomScrollView(slivers: [
                              SliverFillRemaining(
                                  hasScrollBody: false,
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        ConditionsCard(),
                                        SizedBox(height: 23),
                                        AllergiesCard(),
                                        SizedBox(height: 23),
                                        MedicationsCard(),
                                        SizedBox(height: 23),
                                        ImmunizationsCard()
                                      ]))
                            ])),
                            SizedBox(height: 15),
                            FilledButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              IPSResourceSelectionScreen()));
                                },
                                child: Text(AppLocalizations.of(context)!
                                    .shareDataButtonLabel)),
                            SizedBox(height: 5),
                            FilledButton(
                                onPressed: () {
                                  print('Scanning QR Code');
                                },
                                child: Text(AppLocalizations.of(context)!
                                    .scanQRCodeButtonLabel))
                          ]))));
  }
}
