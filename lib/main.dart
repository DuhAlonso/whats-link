import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chama/src/ui/pages/home_page.dart';
import 'package:get/get.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  runApp(GetMaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.green,
      primaryColor: Colors.green,
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
    ),
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
  ));
}
