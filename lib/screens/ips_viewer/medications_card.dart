import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/models/ips_model.dart';

class MedicationsCard extends ConsumerWidget {
  final IpsSource source;

  const MedicationsCard({super.key, required this.source});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var medicationList;

    switch (source) {
      case IpsSource.national:
        medicationList = ref
            .read(ipsModelProvider.select((ips) => ips.medications))
            .asMap()
            .entries;
        break;
      case IpsSource.vhl:
        medicationList = ref
            .read(ipsVhlModelProvider.select((ips) => ips.medications))
            .asMap()
            .entries;
        break;

    }

    return medicationList.length == 0 ? SizedBox.shrink() :
    ExpansionTile(
        initiallyExpanded: true,
        title: Row(
          children: [
            Icon(
              MdiIcons.pillMultiple,
              size: 28,
            ),
            SizedBox(
              width: 10,
            ),
            Text(AppLocalizations.of(context)!
                .medicationsSectionTitle(medicationList.length))
          ],
        ),
        children: <Widget>[
          Divider(
            height: 1,
          ),
          ...medicationList.map((entry) {
            final medInfo = entry.value;
            String effectivePeriodDateString = '';
            if (medInfo.statement?.effectivePeriod?.start != null) {
              effectivePeriodDateString = medInfo
                  .statement!.effectivePeriod!.start!
                  .toIso8601String()
                  .substring(0, 10)
                  .split('-')
                  .reversed
                  .join('-');
            }
            return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                child: Column(children: [
                  entry.key == 0
                      ? SizedBox()
                      : Divider(
                          height: 1,
                        ),
                  entry.key == 0
                      ? SizedBox()
                      : SizedBox(
                          height: 8,
                        ),
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          medInfo.medication.code?.coding?[0].display ?? '',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),
                  medInfo.statement != null
                      ? SizedBox(
                          height: 10,
                        )
                      : Container(),
                  medInfo.statement != null
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "${medInfo.statement!.dosage?[0].doseAndRate?[0].doseQuantity?.value.toString()} ${medInfo.statement!.dosage?[0].doseAndRate?[0].doseQuantity?.unit.toString()} / ${medInfo.statement!.dosage?[0].timing!.repeat!.periodUnit?.name}",
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant),
                            ),
                            Text(effectivePeriodDateString)
                          ],
                        )
                      : Container()
                ]));
          })
        ]);
  }
}
