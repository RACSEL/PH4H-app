import 'package:fhir/primitive_types/uri.dart';
import 'package:fhir/r4/basic_types/fhir_extension.dart';
import 'package:fhir/r4/resource_types/base/entities1/entities1.dart';
import 'package:flutter/material.dart';
import 'package:ips_lacpass_app/constants.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';

typedef BundleIdCountry = ({String? bundleId, String? countryCode});
FhirUri extensionUri =
    FhirUri('http://lacpass.org/fhir/StructureDefinition/resource-origin');
FhirUri bundleIdUri = FhirUri('bundleId');
FhirUri countryUri = FhirUri('country');

class OrganizationDisplay extends StatelessWidget {
  // The extension that will contain the origin information, basically which bundleId it came from.
  // The extension is this format ->
  // [
  //   { "extension": [{ "url": "bundleId", "valueString": "1501" }, { "url": "country", "valueString": "CO" }], "url": "http://lacpass.org/fhir/StructureDefinition/resource-origin" }
  // ],
  final List<FhirExtension>? extensions;

  final List<MapEntry<String, Organization>> organizationList;

  const OrganizationDisplay({
    super.key,
    required this.extensions,
    required this.organizationList,
  });

  BundleIdCountry get _extractBundleIdAndCountry {
    if (extensions == null) {
      return (bundleId: null, countryCode: null);
    }

    final originExtension = extensions!.firstWhere(
      (ext) => ext.url == extensionUri,
      orElse: () => FhirExtension(),
    );

    if (originExtension.extension_ == null) {
      return (bundleId: null, countryCode: null);
    }

    String? bundleId = originExtension.extension_
        ?.firstWhere((ext) => ext.url == bundleIdUri,
            orElse: () => FhirExtension())
        .valueString;

    String? countryCode = originExtension.extension_
        ?.firstWhere((ext) => ext.url == countryUri,
            orElse: () => FhirExtension())
        .valueString;

    return (bundleId: bundleId, countryCode: countryCode);
  }

  String? get _getOrganizationName {
    String? resourceBundleId = _extractBundleIdAndCountry.bundleId;
    String? resourceCountryCode = _extractBundleIdAndCountry.countryCode;

    if (resourceBundleId == null ||
        resourceCountryCode == null ||
        organizationList.isEmpty) {
      return null;
    }

    final organizationEntry = organizationList.firstWhere(
      (entry) {
        FhirExtension? organizationBundleIdExtension = entry.value.extension_
            ?.firstWhere((ext) => ext.url == extensionUri,
                orElse: () => FhirExtension());

        if (organizationBundleIdExtension == null) {
          return false;
        }
        String? organizationBundleId = organizationBundleIdExtension.extension_
            ?.firstWhere((ext) => ext.url == bundleIdUri,
                orElse: () => FhirExtension())
            .valueString;

        String? organizationCountryCode = organizationBundleIdExtension
            .extension_
            ?.firstWhere((ext) => ext.url == countryUri,
                orElse: () => FhirExtension())
            .valueString;

        if (organizationBundleId == null || organizationCountryCode == null) {
          return false;
        }

        return organizationBundleId == resourceBundleId &&
            organizationCountryCode == resourceCountryCode;
      },
      orElse: () => MapEntry('', Organization()),
    );

    if (organizationEntry.value.name != null) {
      return organizationEntry.value.name;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (extensions == null) {
      return const SizedBox.shrink();
    }

    String? organizationName;
    String? countryCode;

    organizationName = _getOrganizationName;
    countryCode = _extractBundleIdAndCountry.countryCode;

    if (organizationName == null || countryCode == null) {
      return const SizedBox.shrink();
    }

    String displayCountryName = Constants.countryOptions.firstWhere(
          (element) => element['value'] == countryCode,
          orElse: () => {'value': '', 'label': '', 'emoji': ''},
        )['emoji'] ??
        countryCode;

    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppLocalizations.of(context)!.organizationsSectionTitle(1),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  "$organizationName $displayCountryName",
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.end,
                  maxLines: 2,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
