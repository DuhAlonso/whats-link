import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chama/src/pages/chama_no_whats/chama_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.green,
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
    ),
    debugShowCheckedModeBanner: false,
    home: const HomePage(),
  ));
}
