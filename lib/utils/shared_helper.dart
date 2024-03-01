import 'package:shared_preferences/shared_preferences.dart';

void saveTheme({required bool isTheme}) async {
  SharedPreferences shr = await SharedPreferences.getInstance();
  shr.setBool("theme", isTheme);
}

Future<bool?> applyTheme() async {
  SharedPreferences shr = await SharedPreferences.getInstance();
  shr.getBool("theme");
  return shr.getBool("theme");
}
