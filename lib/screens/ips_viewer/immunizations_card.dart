import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/models/ips_model.dart';
import 'package:ips_lacpass_app/screens/icvp_qr/icvp_qr_screen.dart';

class ImmunizationsCard extends ConsumerWidget {
  final IpsSource source;

  const ImmunizationsCard({super.key, required this.source});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var immunizationList;

    switch (source) {
      case IpsSource.national:
        immunizationList = ref
            .read(ipsModelProvider.select((ips) => ips.immunizations))
            .entries;
        break;
      case IpsSource.vhl:
        immunizationList = ref
            .read(ipsVhlModelProvider.select((ips) => ips.immunizations))
            .entries;
        break;
    }

    return immunizationList.length == 0
        ? SizedBox.shrink()
        : ExpansionTile(
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
                ...immunizationList.toList().asMap().entries.map((entry) {
                  final immunization = entry.value.value;
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 18, horizontal: 16),
                      child: Column(children: [
                        if (entry.key == 0)
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
                                  immunization.immunization.vaccineCode
                                          .coding?[0].display ??
                                      immunization
                                          .immunization.vaccineCode.text ??
                                      '',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                              source == IpsSource.national &&
                                      immunization.original
                                  ? IconButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, "/icvp-qr",
                                            arguments: ICVPQRScreenArguments(
                                                bundleId: ref
                                                    .read(ipsModelProvider)
                                                    .bundle!["id"],
                                                immunizationId: entry.key
                                                    .toString()
                                                    .split(":")[2]));
                                      },
                                      icon: Icon(MdiIcons.qrcode))
                                  : SizedBox()
                            ])
                      ]));
                })
              ]);
  }
}
