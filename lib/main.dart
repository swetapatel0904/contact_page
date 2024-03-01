import 'package:contact_page/screen/contact/provider/contact_provider.dart';
import 'package:contact_page/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ContactProvider()),
      ],
      child: Consumer<ContactProvider>(
        builder: (context, value, child) {
          value.getTheme();
          value.theme = value.isTheme;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: value.mode,
            routes: app_route,
          );
        },
      ),
    ),
  );
}
