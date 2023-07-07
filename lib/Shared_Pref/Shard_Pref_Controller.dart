
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefController {
  // static const String LANG_CODE_KEY = 'lang_code';

  static final SharedPrefController _instance =
  SharedPrefController._internal();
  late SharedPreferences _sharedPreferences;

  factory SharedPrefController() {
    return _instance;
  }

  // PRIVATE CONSTRUCTOR - NO DEFAULT
  SharedPrefController._internal();

  Future<void> initSharedPreferances() async {
    print("START : initSharedPreferances");
    _sharedPreferences = await SharedPreferences.getInstance();
    print("END : initSharedPreferances");
  }

  SharedPreferences get preferences => _sharedPreferences;

  Future<bool> setUserID(String usedId) async {
    return await _sharedPreferences.setString(
        'user_id', usedId);
  }

  String? getUserID() {
    return _sharedPreferences.getString('user_id');
  }
}