import 'dart:io';

import 'package:contact_page/screen/contact/provider/contact_provider.dart';
import 'package:contact_page/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ContactProvider()),
      ],
      child: Consumer<ContactProvider>(
        builder: (context, value, child) {
          value.getTheme();
          value.theme = value.isTheme;
          return Platform.isAndroid
              ? MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData.light(),
                  darkTheme: ThemeData.dark(),
                  themeMode: value.mode,
                  routes: app_route,
                )
              : CupertinoApp(
                  debugShowCheckedModeBanner: false,
                  routes: cupertino_approutes,
                );
        },
      ),
    ),
  );
}
