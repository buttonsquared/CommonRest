import 'AbstractRestriction.dart';

class GreaterThan extends AbstractRestriction {
  GreaterThan(String value) {
    super.value = value;
    super.className = "com.commonlib.dao.GreaterThan";
  }
}
