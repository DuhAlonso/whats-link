import 'package:chama/src/controllers/home_controller.dart';
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
    getPages: [
      GetPage(
        binding: BindingsBuilder.put(() => HomeController()),
        name: '/',
        page: () => const HomePage(),
      ),
    ],
  ));
}
