import 'AbstractRestriction.dart';

class GeoSearch extends AbstractRestriction {
  num latitude;
  num longitude;
  num radius;

  GeoSearch(this.latitude, this.longitude, this.radius) {
    super.className = "com.commonlib.dao.GeoSearch";
  }

  Map toJson() {
    Map map = super.toJson();
    map["latitude"] = latitude;
    map["longitude"] = longitude;
    map["radius"] = radius;
    return map;
  }
}