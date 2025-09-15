import 'package:flutter/material.dart';
import 'package:fhir/r4.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/models/ips_model.dart';

class ProceduresCard extends ConsumerWidget {
  final IpsSource source;

  const ProceduresCard({super.key, required this.source});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Iterable<MapEntry<String, Procedure>> proceduresList;

    switch (source) {
      case IpsSource.national:
        proceduresList =
            ref.read(ipsModelProvider.select((ips) => ips.procedures)).entries;
        break;
      case IpsSource.vhl:
        proceduresList = ref
            .read(ipsVhlModelProvider.select((ips) => ips.procedures))
            .entries;
        break;
    }

    return proceduresList.isEmpty
        ? SizedBox.shrink()
        : ExpansionTile(
            initiallyExpanded: true,
            title: Row(
              children: [
                Icon(
                  MdiIcons.radiologyBox,
                  size: 28,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(AppLocalizations.of(context)!
                    .proceduresSectionTitle(proceduresList.length))
              ],
            ),
            children: <Widget>[
              Divider(height: 1),
              ...proceduresList.toList().asMap().entries.map((entry) {
                final procedure = entry.value.value;
                final procedureDateTime = procedure.performedDateTime;
                final index = entry.key;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  child: Column(
                    children: [
                      if (index == 0)
                        SizedBox()
                      else ...[
                        Divider(height: 1),
                        SizedBox(height: 8),
                      ],
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              procedure.code?.coding?[0].display ??
                                  procedure.code?.text ??
                                  '',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      if (procedureDateTime != null) ...[
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppLocalizations.of(context)!
                                .procedurePerformedDate),
                            Text(DateFormat('yyyy-MM-dd')
                                .format(procedureDateTime.value))
                          ],
                        )
                      ] else
                        Container(),
                    ],
                  ),
                );
              }),
            ],
          );
  }
}
