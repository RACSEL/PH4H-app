import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/models/ips_model.dart';

class AllergiesCard extends ConsumerWidget {
  final IpsSource source;

  const AllergiesCard({super.key, required this.source});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    var allergyList;

    switch (source) {
      case IpsSource.national:
        allergyList = ref
            .read(ipsModelProvider.select((ips) => ips.allergies))
            .entries;
        break;
      case IpsSource.vhl:
        allergyList = ref
            .read(ipsVhlModelProvider.select((ips) => ips.allergies))
            .entries;
        break;

    }
    return allergyList.length == 0 ? SizedBox.shrink() :
    ExpansionTile(
        initiallyExpanded: true,
        title: Row(
          children: [
            Icon(
              MdiIcons.allergy,
              size: 28,
            ),
            SizedBox(
              width: 10,
            ),
            Text(AppLocalizations.of(context)!
                .allergiesSectionTitle(allergyList.length))
          ],
        ),
        children: <Widget>[
          Divider(
            height: 1,
          ),
          ...allergyList.map((entry) {
            final allergy = entry.value;
            return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Column(children: [
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
                      Flexible(
                          child: Text(
                        allergy.code?.coding?[0].display ?? '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                      SizedBox(
                        width: 8,
                      ),
                      Chip(
                          label: allergy.clinicalStatus?.coding?[0].code.toString() == 'active'
                              ? Text(AppLocalizations.of(context)!.allergyStatusActive,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontWeight: FontWeight.bold))
                              : (allergy.clinicalStatus?.coding?[0].code.toString() == 'resolved'
                                  ? Text(AppLocalizations.of(context)!.allergyStatusResolved,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onTertiary,
                                          fontWeight: FontWeight.bold))
                                  : Text(AppLocalizations.of(context)!.allergyStatusInactive,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .onError,
                                          fontWeight: FontWeight.bold))),
                          backgroundColor: allergy.clinicalStatus?.coding?[0].code.toString() == 'active'
                              ? Theme.of(context).colorScheme.primary
                              : (allergy.clinicalStatus?.coding?[0].code.toString() == 'resolved'
                                  ? Theme.of(context).colorScheme.tertiary
                                  : Theme.of(context).colorScheme.error))
                    ],
                  ),
                ]));
          })
        ]);
  }
}
