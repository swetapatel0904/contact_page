import 'package:contact_page/screen/contact/view/contact_screen.dart';
import 'package:contact_page/screen/contact/view/detail_screen.dart';
import 'package:contact_page/screen/home/home_screen.dart';
import 'package:contact_page/screen/hidden_screen.dart';
import 'package:contact_page/screen/home/homeios_screen.dart';
import 'package:flutter/material.dart';

Map<String, WidgetBuilder> app_route = {
  "/": (context) => const HomeScreen(),
  "add_data": (context) => const ContactScreen(),
  "details":(context) => const DetailScreen(),
  "hide":(context) => const HiddenScreen(),
};
Map <String, WidgetBuilder> cupertino_approutes={
  '/':(context) => HomeIosScreen(),
};