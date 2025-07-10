import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/models/ips_model.dart';

class ImmunizationsCard extends ConsumerWidget {
  const ImmunizationsCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var immunizationList = ref
        .read(ipsModelProvider.select((ips) => ips.immunizations))
        .entries;

    return ExpansionTile(
        initiallyExpanded: true,
        title: Row(
          children: [
            Icon(
              MdiIcons.needle,
              size: 28,
            ),
            SizedBox(
              width: 10,
            ),
            Text(AppLocalizations.of(context)!
                .immunizationSectionTitle(immunizationList.length))
          ],
        ),
        children: <Widget>[
          Divider(height: 1),
          ...immunizationList.map((entry) {
            final immunization = entry.value;
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
                  Row(children: [
                    Flexible(
                      child: Text(
                        immunization.vaccineCode.coding?[0].display ?? '',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    )
                  ])
                ]));
          })
        ]);
  }
}
