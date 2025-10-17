import 'package:fhir/primitive_types/date_time.dart';
import 'package:fhir/r4/basic_types/fhir_extension.dart';
import 'package:fhir/r4/resource_types/base/entities1/entities1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/models/ips_model.dart';
import 'package:ips_lacpass_app/widgets/organization_display.dart';
import 'package:ips_lacpass_app/widgets/resource_card.dart';
import 'package:intl/intl.dart';

class MedicationsCard extends ConsumerWidget {
  final IpsSource source;
  final List<MapEntry<String, Organization>> organizationList;

  const MedicationsCard(
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
    List<MapEntry<int, MedicationInfo>> medicationList;

    List<MapEntry<int, MedicationInfo>> medicationMapSelector(IPSModel ips) =>
        ips.medications.asMap().entries.toList();

    switch (source) {
      case IpsSource.national:
        medicationList =
            ref.read(ipsModelProvider.select(medicationMapSelector));
        break;
      case IpsSource.vhl:
        medicationList =
            ref.read(ipsVhlModelProvider.select(medicationMapSelector));
        break;
    }

    if (medicationList.isEmpty) {
      return const SizedBox.shrink();
    }

    final List<Widget> medicationItems = medicationList
        .map((entry) => _buildMedicationItem(
              context,
              entry.value,
            ))
        .toList();

    return ResourceCard(
      icon: MdiIcons.pill,
      title: AppLocalizations.of(context)!
          .medicationsSectionTitle(medicationItems.length),
      items: medicationItems,
    );
  }

  Widget _buildMedicationItem(BuildContext context, MedicationInfo medication) {
    String dosageAndFrequency = AppLocalizations.of(context)!.noDoseInformation;
    final doseQuantity =
        medication.statement?.dosage?.first.doseAndRate?.first.doseQuantity;
    final timing = medication.statement?.dosage?.first.timing;

    if (doseQuantity != null) {
      final value = doseQuantity.value.toString();
      final unit = doseQuantity.unit.toString();
      final periodUnit = timing?.repeat?.periodUnit?.name;

      if (periodUnit != null) {
        dosageAndFrequency = '$value $unit / ${periodUnit.toLowerCase()}';
      } else {
        dosageAndFrequency = '$value $unit';
      }
    }

    final FhirDateTime? startDate =
        medication.statement?.effectivePeriod?.start;
    final String effectivePeriodDateString = _formatDate(context, startDate);
    final List<FhirExtension>? medicationExtensions =
        medication.medication.extension_;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  medication.medication.code?.coding?.first.display ??
                      medication.medication.code?.text ??
                      '',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
          if (medication.statement != null) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dosageAndFrequency,
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
                Text(
                  effectivePeriodDateString,
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
          ],
          if (medicationExtensions != null)
            OrganizationDisplay(
              organizationList: organizationList,
              extensions: medicationExtensions,
            ),
        ],
      ),
    );
  }
}
