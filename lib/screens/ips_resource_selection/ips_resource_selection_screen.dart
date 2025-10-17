import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/models/ips_model.dart';
import 'package:ips_lacpass_app/screens/share_qr_code/share_qr_code_screen.dart';
import 'package:ips_lacpass_app/utils/error_utils.dart';
import 'package:ips_lacpass_app/utils/ips_utils.dart';
import 'package:ips_lacpass_app/widgets/filled_button.dart';
import 'package:ips_lacpass_app/widgets/patient_appbar/patient_appbar_widget.dart';
import 'package:ips_lacpass_app/widgets/snackbar.dart';

part 'ips_resource_selection_controller.dart';

class IPSResourceSelectionScreen extends ConsumerStatefulWidget {
  const IPSResourceSelectionScreen({super.key});

  @override
  ConsumerState<IPSResourceSelectionScreen> createState() => _IPSViewerScreen();
}

class _IPSViewerScreen extends IPSResourceSelectionController {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PatientAppBar(),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(36, 10, 36, 36),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(AppLocalizations.of(context)!.resourceSelectionTitle,
                style: TextStyle(fontSize: 24)),
            SizedBox(
              height: 23,
            ),
            Text(AppLocalizations.of(context)!.resourceSelectionDescription),
            SizedBox(
              height: 23,
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: true,
                    child: ListView(
                      children: <Widget>[
                        ...ref
                            .read(ipsModelProvider
                                .select((ips) => ips.conditions))
                            .entries
                            .map(
                              (conditionEntry) => CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                value: _selectedConditionsIndex
                                    .contains(conditionEntry.key),
                                onChanged: (newValue) {
                                  setState(() {
                                    if (newValue == true) {
                                      _selectedConditionsIndex
                                          .add(conditionEntry.key);
                                    } else {
                                      _selectedConditionsIndex
                                          .remove(conditionEntry.key);
                                    }
                                  });
                                },
                                title: Row(children: [
                                  Icon(MdiIcons.stethoscope, size: 25),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(AppLocalizations.of(context)!
                                      .conditionsSectionTitle(1))
                                ]),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                subtitle: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(
                                    conditionEntry
                                            .value.code?.coding?[0].display ??
                                        '',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                        ...ref
                            .read(
                                ipsModelProvider.select((ips) => ips.allergies))
                            .entries
                            .map(
                              (allergyEntry) => CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                value: _selectedAllergyIndex
                                    .contains(allergyEntry.key),
                                onChanged: (newValue) {
                                  setState(() {
                                    if (newValue == true) {
                                      _selectedAllergyIndex
                                          .add(allergyEntry.key);
                                    } else {
                                      _selectedAllergyIndex
                                          .remove(allergyEntry.key);
                                    }
                                  });
                                },
                                title: Row(children: [
                                  Icon(MdiIcons.allergy, size: 25),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(AppLocalizations.of(context)!
                                      .allergiesSectionTitle(1))
                                ]),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                subtitle: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(
                                    allergyEntry
                                            .value.code?.coding?[0].display ??
                                        '',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                        ...ref
                            .read(ipsModelProvider
                                .select((ips) => ips.medications))
                            .asMap()
                            .entries
                            .map(
                              (medInfoEntry) => CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                value: _selectedMedicationIndex
                                    .contains(medInfoEntry.key),
                                onChanged: (newValue) {
                                  setState(() {
                                    if (newValue == true) {
                                      _selectedMedicationIndex
                                          .add(medInfoEntry.key);
                                    } else {
                                      _selectedMedicationIndex
                                          .remove(medInfoEntry.key);
                                    }
                                  });
                                },
                                title: Row(children: [
                                  Icon(MdiIcons.pillMultiple, size: 25),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(AppLocalizations.of(context)!
                                      .medicationsSectionTitle(1))
                                ]),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                subtitle: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(
                                    medInfoEntry.value.medication.code
                                            ?.coding?[0].display ??
                                        '',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                        ...ref
                            .read(ipsModelProvider
                                .select((ips) => ips.immunizations))
                            .entries
                            .map(
                              (immunizationEntry) => CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                value: _selectedImmunizationIndex
                                    .contains(immunizationEntry.key),
                                onChanged: (newValue) {
                                  setState(() {
                                    if (newValue == true) {
                                      _selectedImmunizationIndex
                                          .add(immunizationEntry.key);
                                    } else {
                                      _selectedImmunizationIndex
                                          .remove(immunizationEntry.key);
                                    }
                                  });
                                },
                                title: Row(
                                  children: [
                                    Icon(MdiIcons.needle, size: 25),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(AppLocalizations.of(context)!
                                        .immunizationSectionTitle(1))
                                  ],
                                ),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                subtitle: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(
                                    immunizationEntry.value.immunization
                                            .vaccineCode.coding?[0].display ??
                                        '',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                        ...ref
                            .read(ipsModelProvider
                                .select((ips) => ips.procedures))
                            .entries
                            .map(
                              (procedureEntry) => CheckboxListTile(
                                controlAffinity:
                                    ListTileControlAffinity.leading,
                                value: _selectedProceduresIndex
                                    .contains(procedureEntry.key),
                                onChanged: (newValue) {
                                  setState(() {
                                    if (newValue == true) {
                                      _selectedProceduresIndex
                                          .add(procedureEntry.key);
                                    } else {
                                      _selectedProceduresIndex
                                          .remove(procedureEntry.key);
                                    }
                                  });
                                },
                                title: Row(
                                  children: [
                                    Icon(MdiIcons.radiologyBox, size: 25),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(AppLocalizations.of(context)!
                                        .proceduresSectionTitle(1))
                                  ],
                                ),
                                contentPadding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 10),
                                subtitle: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Text(
                                    procedureEntry
                                            .value.code?.coding?[0].display ??
                                        procedureEntry.value.code?.text ??
                                        '',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            Ph4hFilledButton(
              onPressed: hasSelections() ? _showPasscodeDialog : null,
              submitting: _loading,
              buttonLabel:
                  AppLocalizations.of(context)!.generateQrCodeButtonLabel,
              isDisabled: _loading,
              fontSize: 14,
            ),
          ],
        ),
      ),
    );
  }
}
