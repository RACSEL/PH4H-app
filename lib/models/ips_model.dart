import 'package:dio/dio.dart';
import 'package:fhir/r4.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ips_lacpass_app/api/api_manager.dart';
import 'package:ips_lacpass_app/api/ips_loader.dart';

class MedicationInfo {
  final String medicationFullUrl;
  final Medication medication;
  String? statementFullUrl;
  MedicationStatement? statement;

  MedicationInfo({required this.medicationFullUrl, required this.medication, this.statementFullUrl, this.statement});
}

class IPSModel extends ChangeNotifier {
  Map<String, dynamic>? bundle;
  Map<String, Condition> conditions = {};
  Map<String, AllergyIntolerance> allergies = {};
  List<MedicationInfo> medications = [];
  Map<String, Immunization> immunizations = {};
  String? vhl;

  Future<void> initState() async {
    _cleanState();
    bundle = await IPSLoader().fetchIPSFromNationalNode();
    _parseBundle();
    notifyListeners();
  }

  void _cleanState() {
    bundle = null;
    conditions.clear();
    allergies.clear();
    medications.clear();
    immunizations.clear();
  }

  void _parseBundle() {
    Map<String, Medication> medicationEntries = {};
    Map<String, MedicationStatement> medicationStatementsEntries = {};

    if (bundle != null) {
      try {
        for (var item in bundle!['entry']) {
          var resource = item['resource'];
          var resourceType = resource['resourceType'];
          if (resourceType == 'Condition') {
            conditions[item['fullUrl']] = Condition.fromJson(resource);
          } else if (resourceType == 'AllergyIntolerance') {
            if (resource['patient'] == null) {
              resource['patient'] = {"reference": "Patient/unknown"};
            }
            allergies[item['fullUrl']] = AllergyIntolerance.fromJson(resource);
          } else if (resourceType == 'Medication') {
            medicationEntries[item["fullUrl"]] = Medication.fromJson(resource);
          } else if (resourceType == 'MedicationStatement') {
            medicationStatementsEntries[item["fullUrl"]] = MedicationStatement.fromJson(resource);
          } else if (resourceType == 'Immunization') {
            if (resource['patient'] == null) {
              resource['patient'] = {"reference": "Patient/unknown"};
            }

            // Ensure 'vaccineCode' exists (required 1..1)
            if (resource['vaccineCode'] == null) {
              resource['vaccineCode'] = {
                "coding": [
                  {
                    "system": "http://snomed.info/sct",
                    "code": "dummy-code",
                    "display": "Unknown Vaccine"
                  }
                ],
                "text": "Unknown Vaccine"
              };
            }
            immunizations[item["fullUrl"]] = Immunization.fromJson(resource);
          }
        }
        _linkMedicationInfo(medicationEntries, medicationStatementsEntries);
      } catch (e, st) {
        debugPrint('Error parsing bundle: $e');
        debugPrintStack(label: '_parseBundle error', stackTrace: st);
        rethrow;
      }
    }
  }

  void _linkMedicationInfo(Map<String, Medication> medEntries,
      Map<String, MedicationStatement> medStatementEntries) {
    for (var medEntryFullUrl in medEntries.keys) {
      MedicationInfo medInfo = MedicationInfo(medicationFullUrl: medEntryFullUrl, medication: medEntries[medEntryFullUrl]!);
      for (var medStatementEntryFullUrl in medStatementEntries.keys) {
        if (medEntries[medEntryFullUrl]!.fhirId ==
            medStatementEntries[medStatementEntryFullUrl]!.medicationReference?.reference?.split(':').last) {
          medInfo.statementFullUrl = medStatementEntryFullUrl;
          medInfo.statement = medStatementEntries[medStatementEntryFullUrl];
          break;
        }
      }
      medications.add(medInfo);
    }
  }

  Future<void> updateVhl(Map<String, dynamic>? filteredIPS) async {
    try {
      if (filteredIPS != null) {
        final response =  await ApiManager.instance.getVHL(filteredIPS);
        vhl = response.data["data"];
        notifyListeners();
      }
    } on DioException catch (e) {
      debugPrint('Error updating VHL: $e');
      rethrow;
    }
  }

  void clearVhl() async {
   vhl = null;
  }
}

final ipsModelProvider = ChangeNotifierProvider<IPSModel>((ref) {
  return IPSModel();
});
