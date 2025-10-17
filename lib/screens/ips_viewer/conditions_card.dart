import 'package:fhir/primitive_types/date_time.dart';
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
import 'package:intl/intl.dart';

class ConditionsCard extends ConsumerWidget {
  final IpsSource source;
  final List<MapEntry<String, Organization>> organizationList;

  const ConditionsCard(
      {super.key, required this.source, required this.organizationList});

  String _formatDate(BuildContext context, FhirDateTime? dateTime) {
    if (dateTime == null) {
      return '';
    }

    final DateTime date = dateTime.value;
    return DateFormat.yMd(Localizations.localeOf(context).toString())
        .format(date);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<MapEntry<String, Condition>> conditionList;

    switch (source) {
      case IpsSource.national:
        conditionList = ref
            .read(ipsModelProvider.select((ips) => ips.conditions))
            .entries
            .toList();
        break;
      case IpsSource.vhl:
        conditionList = ref
            .read(ipsVhlModelProvider.select((ips) => ips.conditions))
            .entries
            .toList();
        break;
    }

    if (conditionList.isEmpty) {
      return const SizedBox.shrink();
    }

    final List<Widget> conditionItems = conditionList
        .map((entry) => _buildConditionItem(
              context,
              entry.value,
            ))
        .toList();

    return ResourceCard(
      icon: MdiIcons.stethoscope,
      title: AppLocalizations.of(context)!
          .conditionsSectionTitle(conditionList.length),
      items: conditionItems,
    );
  }

  Widget _buildConditionItem(BuildContext context, Condition condition) {
    final String? statusCode =
        condition.clinicalStatus?.coding?.first.code?.toString();

    final bool isActive = statusCode == 'active';

    final String dateString = _formatDate(context, condition.onsetDateTime);

    final List<FhirExtension>? conditionExtensions = condition.extension_;

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
                  condition.code?.coding?.first.display ??
                      condition.code?.text ??
                      '',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
              Chip(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
                label: Text(
                  isActive
                      ? AppLocalizations.of(context)!.conditionStatusActive
                      : AppLocalizations.of(context)!.conditionStatusInactive,
                  style: TextStyle(
                      color: isActive
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.onError,
                      fontWeight: FontWeight.bold),
                ),
                backgroundColor: isActive
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.error,
              )
            ],
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(AppLocalizations.of(context)!.conditionEncounterDiagnosis),
              Text(dateString, style: Theme.of(context).textTheme.bodyMedium),
            ],
          ),
          if (conditionExtensions != null)
            OrganizationDisplay(
              extensions: conditionExtensions,
              organizationList: organizationList,
            ),
        ],
      ),
    );
  }
}
