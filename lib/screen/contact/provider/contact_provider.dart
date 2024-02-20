

import 'package:flutter/material.dart';

import '../model/contact_model.dart';

class ContactProvider with ChangeNotifier
{
  List <ContactModel> contactList=[];
  String path="";
  int index=0;
  bool isLight = true;
  void changeTheme()
  {
    isLight=!isLight;
    notifyListeners();
  }
  void onStepContinue()
  {
    if(index<3)
      {
        index++;
        notifyListeners();
      }
  }
  void onStepCancel()
  {
    if(index>0)
      {
        index--;
        notifyListeners();
      }
  }
  void addPath(String p1)
  {
    path = p1;
    notifyListeners();
  }
  void addContact(ContactModel c1)
  {
    contactList.add(c1);
    notifyListeners();
  }
}