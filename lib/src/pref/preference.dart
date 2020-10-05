import 'package:shared_preferences/shared_preferences.dart';

Future setToken(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("token", value);
}
Future getToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("token");
}
Future rmvToken() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("token");
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

Future setIdDesa(String value) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.setString("idDesa", value);
}
Future getIdDesa() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.getString("idDesa");
}
Future rmvIdDesa() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  return prefs.remove("idDesa");
}