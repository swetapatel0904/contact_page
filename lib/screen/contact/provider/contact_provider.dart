import 'package:flutter/material.dart';

import '../model/contact_model.dart';

class ContactProvider with ChangeNotifier {
  List<ContactModel> contactList = [];
  String path = "";
  int index = 0;
  bool isLight = true;
  bool theme=true;
  String? editImage;

  void changeTheme() {
    isLight = !isLight;

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
  void deleteContact(int i)
  {
    contactList.removeAt(i);
    notifyListeners();
  }
  void updateContact({required int i,required ContactModel c3})
  {
    contactList[i]=c3;
    notifyListeners();
  }
  void editI(int i)
  {
    editImage=contactList[i].image;
    notifyListeners();
  }
 
}
