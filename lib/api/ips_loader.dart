import 'package:ips_lacpass_app/api/api_manager.dart';

class IPSLoader {
  Future<Map<String, dynamic>> fetchIPSFromNationalNode() async {
    final ipsData = await ApiManager.instance.getIps();

    return ipsData.data as Map<String, dynamic>;
  }
}
