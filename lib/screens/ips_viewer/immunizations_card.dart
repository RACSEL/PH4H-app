import 'package:fhir/r4/basic_types/fhir_extension.dart';
import 'package:fhir/r4/resource_types/base/entities1/entities1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/models/ips_model.dart';
import 'package:ips_lacpass_app/screens/icvp_qr/icvp_qr_screen.dart';
import 'package:ips_lacpass_app/widgets/organization_display.dart';
import 'package:ips_lacpass_app/widgets/resource_card.dart';

class ImmunizationsCard extends ConsumerWidget {
  final IpsSource source;
  final List<MapEntry<String, Organization>> organizationList;

  const ImmunizationsCard(
      {super.key, required this.source, required this.organizationList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<MapEntry<String, ImmunizationWithSource>> immunizationList;

    switch (source) {
      case IpsSource.national:
        immunizationList = ref
            .read(ipsModelProvider.select((ips) => ips.immunizations))
            .entries
            .toList();
        break;
      case IpsSource.vhl:
        immunizationList = ref
            .read(ipsVhlModelProvider.select((ips) => ips.immunizations))
            .entries
            .toList();
        break;
    }

    final List<Widget> immunizationItems = immunizationList
        .map((entry) => _buildImmunizationItem(
              context,
              ref,
              entry.value,
              entry.key.toString(),
            ))
        .toList();

    return ResourceCard(
      icon: MdiIcons.needle,
      title: AppLocalizations.of(context)!
          .immunizationSectionTitle(immunizationList.length),
      items: immunizationItems,
    );
  }

  Widget _buildImmunizationItem(BuildContext context, WidgetRef ref,
      ImmunizationWithSource immunization, String entryKey) {
    final List<FhirExtension>? immunizationExtensions =
        immunization.immunization.extension_;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  immunization.immunization.vaccineCode.coding?[0].display ??
                      immunization.immunization.vaccineCode.text ??
                      '',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              if (source == IpsSource.national && immunization.original)
                IconButton(
                  onPressed: () {
                    final String immunizationId = entryKey.split(':')[2];
                    Navigator.pushNamed(context, "/icvp-qr",
                        arguments: ICVPQRScreenArguments(
                            bundleId: ref.read(ipsModelProvider).bundle!["id"],
                            immunizationId: immunizationId));
                  },
                  icon: const Icon(MdiIcons.qrcode),
                )
              else
                const SizedBox(),
            ],
          ),
          if (immunizationExtensions != null)
            OrganizationDisplay(
              organizationList: organizationList,
              extensions: immunizationExtensions,
            ),
        ],
      ),
    );
  }
}
