

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

import '../../../utils/shared_helper.dart';
import '../model/contact_model.dart';

class ContactProvider with ChangeNotifier {
  List<ContactModel> contactList = [];
  List<ContactModel> hiddenList=[];
  String path = "";
  int index = 0;
  bool theme = false;
  String? editImage;
  LocalAuthentication auth = LocalAuthentication();
  bool isAuth = true;
  ThemeMode mode = ThemeMode.light;
  bool isTheme = false;
  IconData themeMode = Icons.dark_mode;


  void setTheme() async {
    theme = !theme;
    saveTheme(isTheme: theme);
    isTheme = (await applyTheme())!;
    if (isTheme == true) {
      mode = ThemeMode.dark;
      themeMode = Icons.light_mode;
    } else if (isTheme == false) {
      mode = ThemeMode.light;
      themeMode = Icons.dark_mode;
    } else {
      mode = ThemeMode.light;
      themeMode = Icons.dark_mode;
    }
    notifyListeners();
  }

  void getTheme() async {
    if (await applyTheme() == null) {
      isTheme = false;
    } else {
      isTheme = (await applyTheme())!;
    }
    if (isTheme == true) {
      mode = ThemeMode.dark;
      themeMode = Icons.light_mode;
    } else if (isTheme == false) {
      mode = ThemeMode.light;
      themeMode = Icons.dark_mode;
    } else {
      mode = ThemeMode.light;
      themeMode = Icons.dark_mode;
    }
    notifyListeners();
  }

  void onStepContinue() {
    if (index < 3) {
      index++;
      notifyListeners();
    }
  }

  void onStepCancel() {
    if (index > 0) {
      index--;
      notifyListeners();
    }
  }

  void addPath(String p1) {
    path = p1;
    notifyListeners();
  }

  void addContact(ContactModel c1) {
    contactList.add(c1);
    notifyListeners();
  }

  void deleteContact(int i) {
    contactList.removeAt(i);
    notifyListeners();
  }

  void updateContact({required int i, required ContactModel c3}) {
    contactList[i] = c3;
    notifyListeners();
  }

  void editI(String i) {
    editImage = i;
    notifyListeners();
  }

  void editPath(String p1) {
    editImage = p1;
    notifyListeners();
  }

  Future<bool?> authLock() async {
    bool isLogin=true;
    bool isLock = await auth.canCheckBiometrics;


    if (isLock) {
      List<BiometricType> l1 = await auth.getAvailableBiometrics();
      if (l1.isNotEmpty) {
        final bool isLogin = await auth.authenticate(
            localizedReason: 'Please authenticate to show hidden contact',
            options: const AuthenticationOptions(biometricOnly: true));
        return isLogin;
      }
    }
  }
  void addHiddenList(int i)
  {
    ContactModel c1=contactList[i];
    hiddenList.add(c1);
    contactList.removeAt(i);

  }
}
