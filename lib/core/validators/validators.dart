import 'package:bmi/data/local/hive_store.dart';

class Validators {
  Validators._();

  static final _emailRegex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$');

  static bool validateEmail(String? val) {
    return (val == null || val.isEmpty || !(_emailRegex.hasMatch(val)));
  }

  static bool validatePassword(String? val) {
    return (val == null ||
        val.isEmpty ||
        !((val.length >= 6) && (val.length <= 14)));
  }

  static bool validateConfirmPassword(String? val1, String? val2) {
    print("$val1, $val2 ${val1 == val2}");
    return (val1 == null ||
        val1.isEmpty ||
        !((val1.length >= 6) && (val1.length <= 14)) ||
        val1 != val2);
  }

  static bool validateName(String? val) {
    return (val == null || val.isEmpty);
  }

  static bool validateProfileName(String? val) {
    if(val==null || val.isEmpty){
      return false;
    }
    if (HiveStore.loadProfiles().any(
      (test) => test.profileName == val.trim(),
    )) {
      return false;
    }
    return true;
  }
}
