part of 'ips_resource_selection_screen.dart';

abstract class IPSResourceSelectionController
    extends ConsumerState<IPSResourceSelectionScreen> {
  final Set<String> _selectedConditionsIndex = {};
  final Set<String> _selectedAllergyIndex = {};
  final Set<int> _selectedMedicationIndex = {};
  final Set<String> _selectedImmunizationIndex = {};
  final Set<String> _selectedProceduresIndex = {};
  final TextEditingController _passcodeController =
      TextEditingController(text: "");
  bool _loading = false;

  bool hasSelections() =>
      _selectedConditionsIndex.isNotEmpty ||
      _selectedAllergyIndex.isNotEmpty ||
      _selectedMedicationIndex.isNotEmpty ||
      _selectedImmunizationIndex.isNotEmpty ||
      _selectedProceduresIndex.isNotEmpty;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _generateFilteredIPS(
      String passcode, BuildContext dialogContext) async {
    setState(() {
      _loading = true;
    });
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
    final filteredProceduresIds = _selectedProceduresIndex.isEmpty
        ? []
        : ref
            .read(ipsModelProvider.select((ips) => ips.procedures))
            .entries
            .where((procedureEntry) =>
                _selectedProceduresIndex.contains(procedureEntry.key))
            .map((entry) => entry.key)
            .toList();
    final selectedUrls = <String>[
      ...filteredConditionsIds,
      ...filteredAllergiesIds,
      ...filteredMedications.expand((medInfo) {
        if (medInfo.statement != null) {
          return [medInfo.medicationFullUrl, medInfo.statementFullUrl];
        }
        return [medInfo.medicationFullUrl];
      }),
      ...filteredImmunizationsIds,
      ...filteredProceduresIds
    ];
    final filteredIPS = IPSUtils.filterIPS(
        ref.read(ipsModelProvider.select((ips) => ips.bundle))!, selectedUrls);

    try {
      await ref
          .read(ipsModelProvider.notifier)
          .updateVhl(filteredIPS, passcode);
      if (mounted) {
        _passcodeController.clear();
        Navigator.pop(dialogContext);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShareQrCodeScreen(),
          ),
        );
      }
    } catch (error) {
      if (mounted) {
        if (error is DioException) {
          showUnexpectedError(context, error);
        } else {
          showTopSnackBar(
            context,
            AppLocalizations.of(context)!.unexpectedErrorMessage,
          );
        }
      }
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  void _showPasscodeDialog() {
    bool isPasscodeVisible = false;
    bool isSubmitting = false;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (BuildContext innerContext, StateSetter innerSetState) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    AppLocalizations.of(innerContext)!.createPasscodeTitleLabel,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: _loading
                        ? null
                        : () {
                            _passcodeController.clear();
                            Navigator.of(dialogContext).pop();
                          },
                  ),
                ],
              ),
              content: TextField(
                controller: _passcodeController,
                keyboardType: TextInputType.text,
                obscureText: !isPasscodeVisible,
                decoration: InputDecoration(
                  labelText:
                      AppLocalizations.of(innerContext)!.passcodeInputLabel,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasscodeVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      innerSetState(() {
                        isPasscodeVisible = !isPasscodeVisible;
                      });
                    },
                  ),
                ),
              ),
              actions: <Widget>[
                SizedBox(
                  width: double
                      .infinity, // This forces the button to take the full width
                  child: Ph4hFilledButton(
                    buttonLabel: AppLocalizations.of(innerContext)!.generate,
                    onPressed: () async {
                      innerSetState(() {
                        isSubmitting = true;
                      });
                      final enteredPasscode = _passcodeController.text;
                      await _generateFilteredIPS(
                          enteredPasscode, dialogContext);
                      innerSetState(() {
                        isSubmitting = false;
                      });
                    },
                    submitting: isSubmitting,
                    isDisabled: isSubmitting,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
