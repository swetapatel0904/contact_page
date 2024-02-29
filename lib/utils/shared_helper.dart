import 'package:shared_preferences/shared_preferences.dart';

void saveTheme(bool isTheme) async {
  SharedPreferences shr = await SharedPreferences.getInstance();
  shr.setBool("theme", isTheme);
}

Future<bool?> getTheme() async {
  SharedPreferences shr = await SharedPreferences.getInstance();
  return shr.getBool("theme");
}
