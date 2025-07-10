import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/models/ips_model.dart';

class ConditionsCard extends ConsumerWidget {
  const ConditionsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var conditionList = ref
        .read(ipsModelProvider.select((ips) => ips.conditions))
        .entries;

    return ExpansionTile(
        initiallyExpanded: true,
        title: Row(
          children: [
            Icon(
              MdiIcons.stethoscope,
              size: 28,
            ),
            SizedBox(
              width: 10,
            ),
            Text(AppLocalizations.of(context)!
                .conditionsSectionTitle(conditionList.length))
          ],
        ),
        children: <Widget>[
          Divider(
            height: 1,
          ),
          ...conditionList.map((entry) {
            final condition = entry.value;
            String dateString = '';
            if (condition.onsetDateTime != null) {
              String date = condition.onsetDateTime?.toIso8601String() ?? '';
              dateString = date.substring(0, 10).split('-').reversed.join('-');
            }

            return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                child: Column(
                  children: [
                    entry.key == 0
                        ? Container()
                        : Divider(
                            height: 1,
                          ),
                    entry.key == 0
                        ? Container()
                        : SizedBox(
                            height: 8,
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          condition.code?.coding?[0].display ?? '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Chip(
                            label: condition.clinicalStatus?.coding?[0].code
                                        .toString() ==
                                    'active'
                                ? Text(
                                    AppLocalizations.of(context)!
                                        .conditionStatusActive,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onPrimary,
                                        fontWeight: FontWeight.bold))
                                : Text(
                                    AppLocalizations.of(context)!
                                        .conditionStatusInactive,
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onError,
                                        fontWeight: FontWeight.bold)),
                            backgroundColor: condition
                                        .clinicalStatus?.coding?[0].code
                                        .toString() ==
                                    'active'
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context).colorScheme.error)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(AppLocalizations.of(context)!
                            .conditionEncounterDiagnosis),
                        Text(dateString)
                      ],
                    ),
                  ],
                ));
          })
        ]);
  }
}
