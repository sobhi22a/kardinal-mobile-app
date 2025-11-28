List<Map<String, dynamic>> convertToValueLabel(
    List<dynamic> data, {
      required String valueKey,
      required String labelKey,
      List<String>? extraKeys, // optional list of extra properties
    }) {
  return data.map((item) {
    final map = item as Map<String, dynamic>;
    final result = <String, dynamic>{
      'value': map[valueKey],
      'label': map[labelKey],
    };

    // Add extra keys if provided and exist in item
    if (extraKeys != null) {
      for (final key in extraKeys) {
        if (map.containsKey(key)) {
          result[key] = map[key];
        }
      }
    }

    return result;
  }).toList();
}