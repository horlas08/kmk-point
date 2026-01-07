Map<String, dynamic> deepParseMap(Map<dynamic, dynamic> map) {
  return map.map((key, value) {
    if (value is Map) {
      return MapEntry(key.toString(), deepParseMap(value));
    } else if (value is List) {
      return MapEntry(key.toString(), deepParseList(value));
    } else {
      return MapEntry(key.toString(), value);
    }
  });
}

List<dynamic> deepParseList(List list) {
  return list.map((item) {
    if (item is Map) {
      return deepParseMap(item);
    } else if (item is List) {
      return deepParseList(item);
    } else {
      return item;
    }
  }).toList();
}