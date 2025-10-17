class IPSUtils {
  static Map<String, dynamic> filterIPS(
      Map<String, dynamic> bundle, List<String> selectedUrls) {
    Map<String, dynamic> filteredBundle = {
      'resourceType': 'Bundle',
      'identifier': {
        "system": bundle['identifier']['system'],
        "value": bundle['identifier']['value']
      },
      'type': bundle['type'],
      'timestamp': bundle['timestamp'],
      'entry': []
    };
    Map<String, dynamic> composition = {};
    for (var entry in bundle['entry']) {
      if (selectedUrls.contains(entry['fullUrl'])) {
        filteredBundle['entry'].add(entry);
      }
      if (entry['resource']['resourceType'] == 'Composition') {
        composition = entry;
      }
    }
    var filteredCompositionSections = [];
    if (composition.isNotEmpty) {
      for (var section in composition['resource']['section']) {
        if (section['entry'] != null && List.of(section['entry']).isNotEmpty) {
          section['entry'] = section['entry']
              .where((ref) => selectedUrls.contains(ref["reference"]))
              .toList();
          filteredCompositionSections.add(section);
        }
      }
      composition['resource']['section'] = filteredCompositionSections;
      filteredBundle['entry'].add(composition);
    }
    return filteredBundle;
  }
}
