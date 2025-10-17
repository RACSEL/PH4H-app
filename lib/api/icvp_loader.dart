import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ICVPLoader {
  static final ICVPLoader _instance = ICVPLoader._internal(); //singleton class

  late FlutterSecureStorage _secureStorage;

  ICVPLoader._internal() {
    _secureStorage = const FlutterSecureStorage();
  }

  static ICVPLoader get instance {
    return _instance;
  }

  Future<void> storeICVP(String id, dynamic data) async {
    Map<String, dynamic> icvpPayload = {};
    if (await _instance.isStored()) {
      icvpPayload = (await _instance.getStoredIcvp()) ?? {};
    }
    icvpPayload.addAll({id: data});

    await _secureStorage.write(key: 'icvp', value: jsonEncode(icvpPayload));
  }

  Future<bool> isStored() async {
    final isIcvpStored = await _secureStorage.read(key: 'icvp');
    return isIcvpStored != null;
  }

  Future<Map<String, dynamic>?> getStoredIcvp() async {
    try {
      final icvpStorage = await _secureStorage.read(key: 'icvp');
      if (icvpStorage != null) {
        final Map<String, dynamic> icvpPayload = jsonDecode(icvpStorage);
        return icvpPayload;
      }
      return null;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  Future<void> clearStoredIcvp() async {
    await _secureStorage.delete(key: 'icvp');
  }
}
