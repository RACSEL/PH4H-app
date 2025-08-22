import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/screens/home/home_screen.dart';
import 'package:ips_lacpass_app/screens/ips_resource_selection/ips_resource_selection_screen.dart';
import 'package:ips_lacpass_app/screens/ips_viewer/allergies_card.dart';
import 'package:ips_lacpass_app/screens/ips_viewer/conditions_card.dart';
import 'package:ips_lacpass_app/models/ips_model.dart';
import 'package:ips_lacpass_app/models/user_model.dart';
import 'package:ips_lacpass_app/screens/ips_viewer/immunizations_card.dart';
import 'package:ips_lacpass_app/screens/ips_viewer/medications_card.dart';
import 'package:ips_lacpass_app/screens/scan_qr/camera_scanner_screen.dart';
import 'package:ips_lacpass_app/widgets/patient_appbar/patient_appbar_widget.dart';
import 'package:ips_lacpass_app/widgets/qr_scanner_button.dart';
import 'package:ips_lacpass_app/widgets/snackbar.dart';

part 'ips_viewer_controller.dart';

class IPSViewerScreen extends ConsumerStatefulWidget {
  final IpsSource source;
  final String? vhlCode;

  const IPSViewerScreen({super.key, required this.source, this.vhlCode});

  @override
  ConsumerState<IPSViewerScreen> createState() => _IPSViewerScreen(source, vhlCode);
}

class _IPSViewerScreen extends IPSViewerController {
  _IPSViewerScreen(IpsSource source, String? vhlCode) : super(source: source, vhlCode: vhlCode);

  @override
  Widget build(BuildContext context) {
    switch (source) {
      case IpsSource.national:
        ref.listen(ipsModelProvider.select((ips) => ips.bundle), (previous, next) {
          if (next != null) {
            setState(() {
              _loading = false;
            });
          }
        });
        break;
      case IpsSource.vhl:
        ref.listen(ipsVhlModelProvider.select((ips) => ips.bundle), (previous, next) {
          if (next != null) {
            setState(() {
              _loading = false;
            });
          }
        });
    }
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
                                        ConditionsCard(source: source),
                                        SizedBox(height: 23),
                                        AllergiesCard(source: source),
                                        SizedBox(height: 23),
                                        MedicationsCard(source: source),
                                        SizedBox(height: 23),
                                        ImmunizationsCard(source: source)
                                      ]))
                            ])),
                            SizedBox(height: 15),
                            source == IpsSource.national  ?
                            FilledButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              IPSResourceSelectionScreen()));
                                },
                                child: Text(AppLocalizations.of(context)!
                                    .shareDataButtonLabel))
                          : FilledButton(
                                onPressed: () {
                                  ref.read(ipsModelProvider).merge(ref.read(ipsVhlModelProvider).bundle)
                                  .then((resp) {
                                    if (mounted) {
                                      Navigator.pushReplacementNamed(
                                          context,
                                          "/ips"
                                      );
                                    }
                                  })
                                  .onError((error, stackTrace) {
                                    if (mounted) {
                                      showTopSnackBar(context, AppLocalizations.of(context)!.unexpectedErrorMessage);
                                    }
                                  })
                                  ;
                                },
                                child: Text(AppLocalizations.of(context)!
                                    .save)),
                            SizedBox(height: 5),
                            source == IpsSource.national ? QRScannerButton()
                                : OutlinedButton(
                                  onPressed: () {
                                    Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        '/home',
                                        (Route<dynamic> route) => false
                                    );
                                },
                                child: Text(AppLocalizations.of(context)!
                                    .cancel))

                          ]))));
  }
}
