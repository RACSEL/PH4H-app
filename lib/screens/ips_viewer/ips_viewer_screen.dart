import 'package:dio/dio.dart';
import 'package:fhir/r4/resource_types/base/entities1/entities1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
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
// import 'package:ips_lacpass_app/screens/ips_viewer/organizations_card.dart';
import 'package:ips_lacpass_app/screens/ips_viewer/procedures_card.dart';
import 'package:ips_lacpass_app/utils/error_utils.dart';
import 'package:ips_lacpass_app/widgets/patient_appbar/patient_appbar_widget.dart';
import 'package:ips_lacpass_app/widgets/qr_scanner_button.dart';
import 'package:ips_lacpass_app/widgets/snackbar.dart';
import 'package:ips_lacpass_app/widgets/update_ips_spinner.dart';

part 'ips_viewer_controller.dart';

class IPSViewerScreen extends ConsumerStatefulWidget {
  final IpsSource source;
  final String? vhlCode;
  final String? passcode;

  const IPSViewerScreen(
      {super.key, required this.source, this.vhlCode, this.passcode});

  @override
  ConsumerState<IPSViewerScreen> createState() =>
      _IPSViewerScreen(source, vhlCode, passcode);
}

class _IPSViewerScreen extends IPSViewerController {
  _IPSViewerScreen(IpsSource source, String? vhlCode, String? passcode)
      : super(source: source, vhlCode: vhlCode, passcode: passcode);

  @override
  Widget build(BuildContext context) {
    List<MapEntry<String, Organization>> organizationList;

    List<MapEntry<String, Organization>> organizationMapSelector(
            IPSModel ips) =>
        ips.organizations.entries.toList();

    switch (source) {
      case IpsSource.national:
        ref.listen(ipsModelProvider.select((ips) => ips.bundle),
            (previous, next) {
          if (next != null) {
            setState(() {
              _loading = false;
            });
          }
        });
        organizationList =
            ref.read(ipsModelProvider.select(organizationMapSelector));
        break;
      case IpsSource.vhl:
        ref.listen(ipsVhlModelProvider.select((ips) => ips.bundle),
            (previous, next) {
          if (next != null) {
            setState(() {
              _loading = false;
            });
          }
        });
        organizationList =
            ref.read(ipsVhlModelProvider.select(organizationMapSelector));
    }
    return Scaffold(
        appBar: PatientAppBar(
          additionalActions: [
            IconButton(
              color: Theme.of(context).colorScheme.primary,
              icon: Icon(MdiIcons.needle),
              onPressed: () {
                Navigator.pushNamed(context, "/icvp-qr/list");
              },
            ),
          ],
        ),
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
                                        // OrganizationsCard(source: source),
                                        ConditionsCard(
                                            source: source,
                                            organizationList: organizationList),
                                        AllergiesCard(
                                            source: source,
                                            organizationList: organizationList),
                                        MedicationsCard(
                                            source: source,
                                            organizationList: organizationList),
                                        ImmunizationsCard(
                                            source: source,
                                            organizationList: organizationList),
                                        ProceduresCard(
                                            source: source,
                                            organizationList: organizationList)
                                      ]))
                            ])),
                            SizedBox(height: 15),
                            source == IpsSource.national
                                ? FilledButton(
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
                                      if (mounted) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  UpdateIpsSpinner(),
                                            ));
                                      }
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)!.save)),
                            SizedBox(height: 5),
                            source == IpsSource.national
                                ? QRScannerButton()
                                : OutlinedButton(
                                    onPressed: () {
                                      Navigator.pushNamedAndRemoveUntil(
                                          context,
                                          '/home',
                                          (Route<dynamic> route) => false);
                                    },
                                    child: Text(
                                        AppLocalizations.of(context)!.cancel))
                          ]))));
  }
}
