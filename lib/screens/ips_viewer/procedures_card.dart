import 'package:flutter/material.dart';
import 'package:fhir/r4.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/models/ips_model.dart';
import 'package:ips_lacpass_app/widgets/organization_display.dart';
import 'package:ips_lacpass_app/widgets/resource_card.dart';

class ProceduresCard extends ConsumerWidget {
  final IpsSource source;
  final List<MapEntry<String, Organization>> organizationList;

  const ProceduresCard(
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
    List<MapEntry<String, Procedure>> proceduresList;

    List<MapEntry<String, Procedure>> procedureMapSelector(IPSModel ips) =>
        ips.procedures.entries.toList();

    switch (source) {
      case IpsSource.national:
        proceduresList =
            ref.read(ipsModelProvider.select(procedureMapSelector));
        break;
      case IpsSource.vhl:
        proceduresList =
            ref.read(ipsVhlModelProvider.select(procedureMapSelector));
        break;
    }

    if (proceduresList.isEmpty) {
      return const SizedBox.shrink();
    }

    final List<Widget> procedureItems = proceduresList
        .map((entry) => _buildProcedureItem(
              context,
              entry.value,
            ))
        .toList();

    return ResourceCard(
      icon: MdiIcons.radiologyBox,
      title: AppLocalizations.of(context)!
          .proceduresSectionTitle(procedureItems.length),
      items: procedureItems,
    );
  }

  Widget _buildProcedureItem(BuildContext context, Procedure procedure) {
    final FhirDateTime? procedureDateTime = procedure.performedDateTime;
    final String dateString = _formatDate(context, procedureDateTime);
    final List<FhirExtension>? procedureExtensions = procedure.extension_;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Flexible(
                child: Text(
                  procedure.code?.coding?.first.display ??
                      procedure.code?.text ??
                      '',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
          if (procedureDateTime != null) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppLocalizations.of(context)!.procedurePerformedDate),
                Text(
                  dateString,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            )
          ],
          if (procedureExtensions != null)
            OrganizationDisplay(
              organizationList: organizationList,
              extensions: procedureExtensions,
            ),
        ],
      ),
    );
  }
}
