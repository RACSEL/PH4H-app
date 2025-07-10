part of 'ips_resource_selection_screen.dart';

abstract class IPSResourceSelectionController
    extends ConsumerState<IPSResourceSelectionScreen> {
  final Set<String> _selectedConditionsIndex = {};
  final Set<String> _selectedAllergyIndex = {};
  final Set<int> _selectedMedicationIndex = {};
  final Set<String> _selectedImmunizationIndex = {};

  @override
  void initState() {
    super.initState();
  }

  void _generateFilteredIPS() async {
    final filteredConditionsIds = _selectedConditionsIndex.isEmpty
        ? []
        : ref
            .read(ipsModelProvider.select((ips) => ips.conditions))
            .entries
            .where((conditionEntry) =>
                _selectedConditionsIndex.contains(conditionEntry.key))
            .map((entry) => entry.key)
            .toList();
    final filteredAllergiesIds = _selectedAllergyIndex.isEmpty
        ? []
        : ref
            .read(ipsModelProvider.select((ips) => ips.allergies))
            .entries
            .where((allergyEntry) =>
                _selectedAllergyIndex.contains(allergyEntry.key))
            .map((entry) => entry.key)
            .toList();
    final filteredMedications = _selectedMedicationIndex.isEmpty
        ? []
        : ref
            .read(ipsModelProvider.select((ips) => ips.medications))
            .asMap()
            .entries
            .where((medInfoEntry) =>
                _selectedMedicationIndex.contains(medInfoEntry.key))
            .map((entry) => entry.value)
            .toList();
    final filteredImmunizationsIds = _selectedImmunizationIndex.isEmpty
        ? []
        : ref
            .read(ipsModelProvider.select((ips) => ips.immunizations))
            .entries
            .where((immunizationEntry) =>
                _selectedImmunizationIndex.contains(immunizationEntry.key))
            .map((entry) => entry.key)
            .toList();
    final selectedUrls = <String>[
      ...filteredConditionsIds,
      ...filteredAllergiesIds,
      ...filteredMedications.expand((medInfo) {
        if (medInfo.statement != null) {
          return [
            medInfo.medicationFullUrl,
            medInfo.statementFullUrl
          ];
        }
        return [
          medInfo.medicationFullUrl
        ];
      }),
      ...filteredImmunizationsIds
    ];
    // print('Filtered IPS:');
    final filteredIPS = IPSUtils.filterIPS(
        ref.read(ipsModelProvider.select((ips) => ips.bundle))!, selectedUrls);

    try {
      await ref.read(ipsModelProvider.notifier).updateVhl(filteredIPS);
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShareQrCodeScreen(),
          ),
        );
      }
    } catch (e) {
      print(e);
      if (mounted) {
        showTopSnackBar(
            context,
            AppLocalizations.of(context)!.unexpectedErrorMessage,
            backgroundColor: Theme.of(context).colorScheme.error,
            textColor:  Theme.of(context).colorScheme.onError,
        );
      }
    }
  }
}
