import 'package:flutter/material.dart';
import 'package:ips_lacpass_app/l10n/app_localizations.dart';
import 'package:ips_lacpass_app/models/document_type.dart';

class DocumentTypeSelect extends StatelessWidget {
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const DocumentTypeSelect({
    super.key,
    required this.selectedValue,
    required this.onChanged,
  });

  List<DropdownMenuItem<String>> getLocalizedDocumentTypeOptions(
      BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return [
      DropdownMenuItem(
        value: DocumentType.dni.value,
        child: Text(localizations.documentTypeIdentifier),
      ),
      DropdownMenuItem(
        value: DocumentType.passport.value,
        child: Text(localizations.documentTypePassport),
      ),
    ];
  }

  String? _docTypeValidator(BuildContext context, String? value) {
    if (value == null || value.isEmpty) {
      return AppLocalizations.of(context)!.emptyDocumentTypeValidation;
    }

    if (!DocumentType.stringValues.contains(value)) {
      return AppLocalizations.of(context)!.invalidDocumentTypeValidation;
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: AppLocalizations.of(context)!.documentTypeSelectLabel,
          hintText: AppLocalizations.of(context)!.documentTypeSelectHintText),
      items: getLocalizedDocumentTypeOptions(context),
      onChanged: onChanged,
      validator: (value) => _docTypeValidator(context, value),
    );
  }
}
