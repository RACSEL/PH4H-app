import 'package:fhir/r4/general_types/general_types.dart';
import 'package:fhir/r4/resource_types/base/entities1/entities1.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_design_icons/flutter_material_design_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/models/ips_model.dart';
import 'package:ips_lacpass_app/widgets/resource_card.dart';

class OrganizationsCard extends ConsumerWidget {
  final IpsSource source;

  const OrganizationsCard({super.key, required this.source});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<MapEntry<String, Organization>> organizationList;

    List<MapEntry<String, Organization>> organizationMapSelector(
            IPSModel ips) =>
        ips.organizations.entries.toList();

    switch (source) {
      case IpsSource.national:
        organizationList =
            ref.read(ipsModelProvider.select(organizationMapSelector));
        break;
      case IpsSource.vhl:
        organizationList =
            ref.read(ipsVhlModelProvider.select(organizationMapSelector));
        break;
    }

    if (organizationList.isEmpty) {
      return const SizedBox.shrink();
    }

    final List<Widget> organizationItems = organizationList
        .map((entry) => _buildOrganizationItem(
              context,
              entry.value,
            ))
        .toList();

    return ResourceCard(
      icon: MdiIcons.officeBuildingOutline,
      title: AppLocalizations.of(context)!
          .organizationsSectionTitle(organizationItems.length),
      items: organizationItems,
    );
  }

  Widget _buildOrganizationItem(
      BuildContext context, Organization organization) {
    final String name = organization.name ?? '';

    final address = organization.address?.first;
    String addressString = '';
    if (address != null) {
      final List<String> addressParts = [
        ...(address.line ?? [address.text ?? '']),
        address.city,
        address.state,
        address.postalCode,
        address.country,
      ]
          .where((part) => part != null && part.isNotEmpty)
          .cast<String>()
          .toList();
      addressString = addressParts.join(', ');
    }

    final phone = organization.telecom?.firstWhere(
      (t) => t.system?.toString() == 'phone',
      orElse: () => ContactPoint(system: null),
    );
    final String phoneNumber = phone?.value ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
          const SizedBox(height: 6),
          if (addressString.isNotEmpty) ...[
            _buildDetailRow(context, AppLocalizations.of(context)!.labelAddress,
                addressString),
            const SizedBox(height: 4),
          ],
          if (phoneNumber.isNotEmpty)
            _buildDetailRow(
                context, AppLocalizations.of(context)!.labelPhone, phoneNumber),
        ],
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
