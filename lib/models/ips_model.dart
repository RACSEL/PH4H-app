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

  MedicationInfo(
      {required this.medicationFullUrl,
      required this.medication,
      this.statementFullUrl,
      this.statement});

  Map<String, dynamic> toJson() {
    return {
      'medicationFullUrl': medicationFullUrl,
      'medication': medication.toJson(),
      'statementFullUrl': statementFullUrl,
      'statement': statement?.toJson(),
    };
  }

  MedicationInfo.fromJson(Map<String, dynamic> json)
      : medicationFullUrl = json['medicationFullUrl'],
        medication = Medication.fromJson(json['medication']),
        statementFullUrl = json['statementFullUrl'],
        statement = json['statement'] != null
            ? MedicationStatement.fromJson(json['statement'])
            : null;
}

class ImmunizationWithSource {
  Immunization immunization;

  // flag to indicate if the immunization comes in the original IPS (true)
  // or comes as a result of a IPS merge (false)
  bool original;

  ImmunizationWithSource({required this.immunization, required this.original});

  Map<String, dynamic> toJson() {
    return {
      'immunization': immunization.toJson(),
      'original': original,
    };
  }

  ImmunizationWithSource.fromJson(Map<String, dynamic> json)
      : immunization = Immunization.fromJson(json['immunization']),
        original = json['original'];
}

enum IpsSource { national, vhl }

class IPSModel extends ChangeNotifier {
  bool isInStorage = false;
  Map<String, dynamic>? bundle;
  Map<String, Condition> conditions = {};
  Map<String, AllergyIntolerance> allergies = {};
  List<MedicationInfo> medications = [];
  Map<String, ImmunizationWithSource> immunizations = {};
  Map<String, Procedure> procedures = {};
  Map<String, bool> originalImmunizations = {};
  String? vhl;
  Map<String, dynamic>? vhlPayload;

  Future<bool> checkStorage() async {
    isInStorage = await IPSLoader.instance.isStored();
    notifyListeners();
    return isInStorage;
  }

  Future<void> initState() async {
    _cleanState();
    var ips = await IPSLoader.instance.getStoredIps();
    if (ips != null) {
      isInStorage = true;
      bundle = ips.$1;
      conditions = ips.$2;
      allergies = ips.$3;
      medications = ips.$4;
      immunizations = ips.$5;
      procedures = ips.$6;
      originalImmunizations.clear();
      for (var immunization in immunizations.values) {
        originalImmunizations[immunization.immunization.vaccineCode.coding![0]
            .code!.value!] = immunization.original;
      }
    } else {
      bundle = await IPSLoader.instance.fetchIPSFromNationalNode();
      _parseBundle();
      originalImmunizations.clear();
      for (var immunization in immunizations.values) {
        immunization.original = true;
        originalImmunizations[immunization
            .immunization.vaccineCode.coding![0].code!.value!] = true;
      }
      await IPSLoader.instance.storeIps(bundle!, conditions, allergies,
          medications, immunizations, procedures);
      isInStorage = true;
    }
    notifyListeners();
  }

  Future<void> initStateWithVhlCode(String vhlCode) async {
    throw Exception(
        "IpsModel cannot be initialized with VhlCode. Use initState instead.");
  }

  void _cleanState() {
    bundle = null;
    conditions.clear();
    allergies.clear();
    medications.clear();
    immunizations.clear();
    isInStorage = false;
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
            medicationStatementsEntries[item["fullUrl"]] =
                MedicationStatement.fromJson(resource);
          } else if (resourceType == 'Procedure') {
            procedures[item["fullUrl"]] = Procedure.fromJson(resource);
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
            immunizations[item["fullUrl"]] = ImmunizationWithSource(
                immunization: Immunization.fromJson(resource), original: false);
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
      MedicationInfo medInfo = MedicationInfo(
          medicationFullUrl: medEntryFullUrl,
          medication: medEntries[medEntryFullUrl]!);
      for (var medStatementEntryFullUrl in medStatementEntries.keys) {
        if (medEntries[medEntryFullUrl]!.fhirId ==
            medStatementEntries[medStatementEntryFullUrl]!
                .medicationReference
                ?.reference
                ?.split(':')
                .last) {
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
        final response = await ApiManager.instance.getVHL(filteredIPS);
        vhl = response.data["data"];
        vhlPayload = response.data["payload"];
        notifyListeners();
      }
    } on DioException catch (e) {
      debugPrint('Error updating VHL: $e');
      rethrow;
    }
  }

  void clearVhl() {
    vhl = null;
  }

  Future<void> clear() async {
    vhl = null;
    bundle = null;
    conditions.clear();
    allergies.clear();
    medications.clear();
    immunizations.clear();
    originalImmunizations.clear();
    await IPSLoader.instance.clearStoredIps();
    isInStorage = false;
  }

  Future<void> merge(Map<String, dynamic>? newIps) async {
    if (newIps != null) {
      final newBundleResp = await ApiManager.instance.mergeIps(bundle!, newIps);
      _cleanState();
      bundle = newBundleResp.data;
      _parseBundle();
      for (var immunization in immunizations.values) {
        if (originalImmunizations.containsKey(
            immunization.immunization.vaccineCode.coding![0].code!.value!)) {
          immunization.original = true;
        } else {
          originalImmunizations[immunization
              .immunization.vaccineCode.coding![0].code!.value!] = false;
        }
      }
      await IPSLoader.instance.storeIps(bundle!, conditions, allergies,
          medications, immunizations, procedures);
      isInStorage = true;
      notifyListeners();
    } else {
      throw Exception("newIps cannot be null");
    }
  }
}

final ipsModelProvider = ChangeNotifierProvider<IPSModel>((ref) {
  return IPSModel();
});

class IpsVhlModel extends IPSModel {
  @override
  Future<void> initState() async {
    throw Exception(
        "IpsVhlModel cannot be initialized directly. Use initStateWithVhlCode instead.");
  }

  @override
  Future<void> initStateWithVhlCode(String vhlCode) async {
    _cleanState();
    bundle = await IPSLoader.instance.fetchIPSWithVhlFromNationalNode(vhlCode);
    _parseBundle();
    notifyListeners();
  }
}

final ipsVhlModelProvider = ChangeNotifierProvider<IpsVhlModel>((ref) {
  return IpsVhlModel();
});
