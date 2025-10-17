import 'dart:convert';

import 'package:fhir/r4.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ips_lacpass_app/api/api_manager.dart';
import 'package:ips_lacpass_app/constants.dart';
import 'package:ips_lacpass_app/models/ips_model.dart';

class IPSLoader {
  static final IPSLoader _instance = IPSLoader._internal(); //singleton class

  late FlutterSecureStorage _secureStorage;

  IPSLoader._internal() {
    _secureStorage = const FlutterSecureStorage();
  }

  static IPSLoader get instance {
    return _instance;
  }

  Future<void> storeIps(
      Map<String, dynamic> ips,
      Map<String, Condition> conditions,
      Map<String, AllergyIntolerance> allergies,
      List<MedicationInfo> medications,
      Map<String, ImmunizationWithSource> immunizations,
      Map<String, Procedure> procedures,
      Map<String, Organization> organizations) async {
    final Map<String, dynamic> ipsPayload = {
      'ips': ips,
      'conditions': conditions,
      'allergies': allergies,
      'medications': medications,
      'immunizations': immunizations,
      'procedures': procedures,
      'organizations': organizations,
      'exp': DateTime.now()
          .add(Duration(days: Constants.ipsExpirationDays))
          .millisecondsSinceEpoch
    };
    await _secureStorage.write(key: 'ips', value: jsonEncode(ipsPayload));
  }

  Future<bool> isStored() async {
    final ipsStorage = await _secureStorage.read(key: 'ips');
    if (ipsStorage != null) {
      final Map<String, dynamic> ipsPayload = jsonDecode(ipsStorage);
      if (DateTime.now().millisecondsSinceEpoch < ipsPayload['exp']) {
        return true;
      } else {
        await _secureStorage.delete(key: 'ips');
      }
    }
    return false;
  }

  Future<
      (
        Map<String, dynamic>,
        Map<String, Condition>,
        Map<String, AllergyIntolerance>,
        List<MedicationInfo>,
        Map<String, ImmunizationWithSource>,
        Map<String, Procedure>,
        Map<String, Organization>,
      )?> getStoredIps() async {
    try {
      final ipsStorage = await _secureStorage.read(key: 'ips');
      if (ipsStorage != null) {
        final Map<String, dynamic> ipsPayload = jsonDecode(ipsStorage);
        if (DateTime.now().millisecondsSinceEpoch < ipsPayload['exp']) {
          final Map<String, dynamic> conditionsRaw = ipsPayload['conditions'];
          final Map<String, dynamic> allergiesRaw = ipsPayload['allergies'];
          final List<dynamic> medicationsRaw = ipsPayload['medications'];
          final Map<String, dynamic> proceduresRaw = ipsPayload['procedures'];
          final Map<String, dynamic> organizationsRaw =
              ipsPayload['organizations'];
          final Map<String, dynamic> immunizationsRaw =
              ipsPayload['immunizations'];

          return (
            ipsPayload['ips'] as Map<String, dynamic>,
            conditionsRaw
                .map((key, value) => MapEntry(key, Condition.fromJson(value))),
            allergiesRaw.map((key, value) =>
                MapEntry(key, AllergyIntolerance.fromJson(value))),
            medicationsRaw
                .map((item) => MedicationInfo.fromJson(item))
                .toList(),
            immunizationsRaw.map((key, value) =>
                MapEntry(key, ImmunizationWithSource.fromJson(value))),
            proceduresRaw
                .map((key, value) => MapEntry(key, Procedure.fromJson(value))),
            organizationsRaw.map(
                (key, value) => MapEntry(key, Organization.fromJson(value)))
          );
        } else {
          await _secureStorage.delete(key: 'ips');
        }
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<Map<String, dynamic>> fetchIPSFromNationalNode() async {
    Map<String, dynamic>? ips;
    try {
      final ipsData = await ApiManager.instance.getIps();
      ips = ipsData.data as Map<String, dynamic>?;
      if (ips == null) {
        throw Exception('Failed to fetch IPS');
      }
      return ips;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> clearStoredIps() async {
    await _secureStorage.delete(key: 'ips');
  }

  Future<Map<String, dynamic>> fetchIPSWithVhlFromNationalNode(
      String vhlCode, String passcode) async {
    final ipsData = await ApiManager.instance.getIpsVhl(vhlCode, passcode);

    return ipsData.data as Map<String, dynamic>;
  }
}
