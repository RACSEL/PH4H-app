import 'package:flutter/material.dart';
import 'package:ips_lacpass_app/constants.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/models/document_type.dart';

class NationalIdInput extends StatelessWidget {
  final String? selectedDocumentType;
  final String? selectedCountryCode;
  final ValueChanged<String?> onChangedCountryCode;
  final String? id;
  final ValueChanged<String?> onChangedId;

  const NationalIdInput({
    super.key,
    required this.selectedCountryCode,
    required this.onChangedCountryCode,
    required this.id,
    required this.onChangedId,
    required this.selectedDocumentType,
  });

  String? countryValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.emptyCountryValidation;
    }
    if (!Constants.countryOptions.any((country) => country['value'] == value)) {
      return AppLocalizations.of(context)!.invalidCountryValidation;
    }
    return null;
  }

  String? inputIdValidator(String? value, BuildContext context) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.emptyIdentifierValidation;
    }
    if (selectedDocumentType == DocumentType.dni.value) {
      if (!Constants.dniRegex.hasMatch(value)) {
        return AppLocalizations.of(context)!.invalidIdentifierFormatValidation;
      }
    } else if (selectedDocumentType == DocumentType.passport.value) {
      if (!Constants.passportRegex.hasMatch(value)) {
        return AppLocalizations.of(context)!.invalidPassportFormatValidation;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField(
            value: selectedCountryCode,
            isExpanded: true,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.countryInputLabel,
              border: OutlineInputBorder(),
            ),
            items: Constants.countryOptions.map((Map<String, String> country) {
              return DropdownMenuItem(
                value: country['value'],
                child: Text(
                  country['label']!,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
              );
            }).toList(),
            onChanged: onChangedCountryCode,
            validator: (value) => countryValidator(value, context),
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            initialValue: id,
            onTapOutside: (PointerDownEvent event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            enableSuggestions: false,
            autocorrect: false,
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.identifierInputLabel,
              border: OutlineInputBorder(),
            ),
            onChanged: onChangedId,
            validator: (value) => inputIdValidator(value, context),
          ),
        )
      ],
    );
  }
}
