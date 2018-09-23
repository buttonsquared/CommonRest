class AbstractRestriction {
  String className = "NONE";
  String value;

  Map toJson() {
    Map map = new Map();
    map["className"] = className;
    map["value"] = value;
    return map;
  }
}