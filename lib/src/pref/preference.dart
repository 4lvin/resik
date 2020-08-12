import 'package:shared_preferences/shared_preferences.dart';

Future setIsLogin(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("isLogin", value);
}
Future getIsLogin() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("isLogin");
}
Future rmvIsLogin() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("isLogin");
}

Future setNama(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("nama", value);
}
Future getNama() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("nama");
}
Future rmvNama() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("nama");
}

Future setId(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("id", value);
}
Future getId() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("id");
}
Future rmvId() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("id");
}