import 'package:shared_preferences/shared_preferences.dart';

class PrefManager {
  String kToken = "api_key";
  String kUserId = "userId";
  String kProvinceId = "province_id";
  String kUser = "user";
  PrefManager(this.preferences);

  /// Light, Dark ,System

  late SharedPreferences preferences;

  //for Bloc.Bloc.login
  set provinceId(String value) => preferences.setString(kProvinceId, value);

  set token(String? value) => preferences.setString(kToken, value ?? "");

  String? get token => preferences.getString(kToken);
  // String? get token => "";

  set user(String? value) => preferences.setString(kUser, value ?? "");

  String? get user => preferences.getString(kUser);

  set userId(String? value) => preferences.setString(kUserId, value ?? "");

  String? get userId => preferences.getString(kUserId);
  /////////

  void logout() {
    preferences.clear();
  }
}
