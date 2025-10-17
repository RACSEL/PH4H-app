import 'package:fhir/r4/basic_types/fhir_extension.dart';
import 'package:fhir/r4/resource_types/base/entities1/entities1.dart';
import 'package:fhir/r4/resource_types/clinical/summary/summary.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/models/ips_model.dart';
import 'package:ips_lacpass_app/widgets/organization_display.dart';
import 'package:ips_lacpass_app/widgets/resource_card.dart';

class AllergiesCard extends ConsumerWidget {
  final IpsSource source;
  final List<MapEntry<String, Organization>> organizationList;

  const AllergiesCard(
      {super.key, required this.source, required this.organizationList});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<MapEntry<String, AllergyIntolerance>> allergyList;

    switch (source) {
      case IpsSource.national:
        allergyList = ref
            .read(ipsModelProvider.select((ips) => ips.allergies))
            .entries
            .toList();
        break;
      case IpsSource.vhl:
        allergyList = ref
            .read(ipsVhlModelProvider.select((ips) => ips.allergies))
            .entries
            .toList();
        break;
    }

    if (allergyList.isEmpty) {
      return const SizedBox.shrink();
    }

    final List<Widget> allergyItems = allergyList
        .map((entry) => _buildAllergyItem(
              context,
              entry.value,
            ))
        .toList();

    return ResourceCard(
      icon: MdiIcons.allergy,
      title: AppLocalizations.of(context)!
          .allergiesSectionTitle(allergyItems.length),
      items: allergyItems,
    );
  }

  Widget _buildAllergyItem(BuildContext context, AllergyIntolerance allergy) {
    final List<FhirExtension>? allergyExtensions = allergy.extension_;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 4,
            children: [
              Flexible(
                  child: Text(
                allergy.code?.coding?[0].display ?? '',
                style: TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              )),
              Chip(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                  label: allergy.clinicalStatus?.coding?[0].code.toString() ==
                          'active'
                      ? Text(AppLocalizations.of(context)!.allergyStatusActive,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold))
                      : (allergy.clinicalStatus?.coding?[0].code.toString() ==
                              'resolved'
                          ? Text(AppLocalizations.of(context)!.allergyStatusResolved,
                              style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onTertiary,
                                  fontWeight: FontWeight.bold))
                          : Text(AppLocalizations.of(context)!.allergyStatusInactive,
                              style: TextStyle(
                                  color: Theme.of(context).colorScheme.onError,
                                  fontWeight: FontWeight.bold))),
                  backgroundColor:
                      allergy.clinicalStatus?.coding?[0].code.toString() == 'active'
                          ? Theme.of(context).colorScheme.primary
                          : (allergy.clinicalStatus?.coding?[0].code.toString() ==
                                  'resolved'
                              ? Theme.of(context).colorScheme.tertiary
                              : Theme.of(context).colorScheme.error))
            ],
          ),
          if (allergyExtensions != null)
            OrganizationDisplay(
              extensions: allergyExtensions,
              organizationList: organizationList,
            ),
        ],
      ),
    );
  }
}
