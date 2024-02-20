import 'package:contact_page/screen/contact/view/contact_screen.dart';
import 'package:contact_page/screen/contact/view/home_screen.dart';
import 'package:flutter/material.dart';

Map <String, WidgetBuilder> app_route={
  "/":(context) => HomeScreen(),
  "add_data":(context) => ContactScreen(),


};